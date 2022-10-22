import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios'

import './assets/main.css'

const app = createApp(App)

axios.defaults.baseURL = import.meta.env.VITE_API_ROOT

app.use(router)

app.mount('#app')
