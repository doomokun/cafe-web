def label = "slave-${UUID.randomUUID().toString()}"

def helmInit() {
  	println "初始化 helm client"
  	// sh "helm init --client-only --stable-repo-url https://mirror.azure.cn/kubernetes/charts/"
}

def helmDeploy(Map args) {
	helmInit()

	if (args.dry_run) {
		println "Debug 应用"
		sh """
			helm upgrade --install ${args.name} ${args.chartDir} \
			--dry-run --debug \
			--set appWeb.image.repository=${args.image} \
			--set appWeb.image.tag=${args.tag} \
			--set appWeb.service.type=NodePort \
			--namespace=${args.namespace} \
			--create-namespace
		"""
	} else {
		println "部署应用"
		sh """
			helm upgrade --install ${args.name} ${args.chartDir} \
			--set appWeb.image.repository=${args.image} \
			--set appWeb.image.tag=${args.tag} \
			--set appWeb.service.type=NodePort \
			--namespace=${args.namespace} \
			--create-namespace
		"""
		echo "应用 ${args.name} 部署成功. 可以使用 helm status ${args.name} 查看应用状态"
	}
}

podTemplate(label: label, containers: [
	containerTemplate(name: 'kubectl', image: 'cnych/kubectl', command: 'cat', ttyEnabled: true),
	containerTemplate(name: 'helm', image: 'cnych/helm', command: 'cat', ttyEnabled: true),
	containerTemplate(name: 'kaniko', image: 'gcr.io/kaniko-project/executor:debug', command: 'cat', ttyEnabled: true)
], volumes: [
  	secretVolume(mountPath: '/kaniko/.docker', secretName: 'dockercred')
]) {
	node(label) {
		def imageEndpoint = "tommydevv1/cafe-web"
		def appName = "3-tier-app"

		stage('Fetch code') {
			git branch: 'develop', credentialsId: 'jenkins-key', url: 'https://github.com/doomokun/cafe-web.git'
			script {
				imageTag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
			}
		}
		stage('Replace Docker ENV') {
			container('kubectl') {
				def apiServerIP = sh(returnStdout: true, script: "kubectl get nodes -l node-role.kubernetes.io/control-plane --all-namespaces -o jsonpath=\"{\$.items[*].status.addresses[?(@.type=='ExternalIP')].address}\"")
				def apiServerPort = "30316"
				try {
					apiServerPort = sh(returnStdout: true, script: "kubectl get svc app-server -n 3-tier-app -o jsonpath='{\$.spec.ports[0].nodePort}'")
				} catch (exc) {
					println "Get Server IP Fail - ${currentBuild.fullDisplayName} - Skip"
				}
				sh "sed -i 's/<VITE_API_ROOT>/${apiServerIP}:${apiServerPort}/' Dockerfile"
			}
		}
		stage('kaniko 构建 Docker 镜像') {
			container('kaniko') {
				sh "/kaniko/executor --context `pwd` --destination ${imageEndpoint}:${imageTag}"
			}
		}
		stage('运行 Helm') {
			container('helm') {
				echo "4. [INFO] 开始 Helm 部署"
				helmDeploy(
					dry_run     : false,
					name        : "${appName}",
					chartDir    : "./docs",
					namespace   : "${appName}",
					tag         : "${imageTag}",
					image       : "${imageEndpoint}"
				)
				echo "[INFO] Helm 部署应用成功..."
			}
		}
	}
}
