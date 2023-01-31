import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import VueSweetAlert2 from 'vue-sweetalert2'
import 'sweetalert2/dist/sweetalert2.min.css'
import './assets/main.css'

const app = createApp(App)

// CHANGE THIS TO YOUR BACKEND SERVER
app.config.globalProperties.$hostname = 'http://100.26.234.87:3000'

app.use(VueSweetAlert2)
app.use(router)

app.mount('#app')
