# cafe-web-chart

# Chart pages
pages: https://doomokun.github.io/cafe-web

repo: https://github.com/doomokun/cafe-web
git: git@github.com:doomokun/cafe-web.git

branch: develop/docs

# Helm Commands
```
$ helm repo add cafe-web-repo https://doomokun.github.io/cafe-web

$ helm package .
$ helm repo index .
$ helm repo index . --url https://doomokun.github.io/cafe-web

$ helm upgrade --install app-web cafe-web-repo/cafe-web --set appServer.image.repository=${args.image} --set appServer.image.tag=${args.tag} --namespace=3-tier-app --create-namespace

$ helm repo list
$ helm search repo
$ helm install #{chart name you like} #{helm search repo NAME}

$ helm list
$ helm delete #{NAME}
$ helm delete --purge #{NAME}
```