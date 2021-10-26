import App from '@/components/App.vue'
import { createApp, provide, h } from 'vue'
import { DefaultApolloClient } from '@vue/apollo-composable'
import { apolloClient } from '@/graphql/client'
import router from '@/router/router'
import 'bootstrap'
import '@/stylesheets/main.scss'

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

document.addEventListener('DOMContentLoaded', () => {
  app.mount('[data-behavior="vue-app"]')
})