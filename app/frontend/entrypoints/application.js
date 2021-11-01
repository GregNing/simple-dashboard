import App from '@/components/App.vue'
import { createApp, provide, h } from 'vue'
import { DefaultApolloClient } from '@vue/apollo-composable'
import { apolloClient } from '@/graphql/client'
import router from '@/router/router'
import 'bootstrap'
import '@/stylesheets/main.scss'
import GAuth from 'vue3-google-oauth2'
import store from '@/store/Index'

const gAuthOptions = { clientId: import.meta.env.VITE_GOOGLE_CLIENT_ID, scope: 'email profile' }

const app = createApp({
  setup() {
    provide(DefaultApolloClient, apolloClient)
    return {}
  },
  render() {
    return h(App)
  },
})

app.use(router)
app.use(store)
app.use(GAuth, gAuthOptions)

document.addEventListener('DOMContentLoaded', () => {
  app.mount('[data-behavior="vue-app"]')
})
