import { ApolloClient, InMemoryCache, createHttpLink, from } from '@apollo/client/core'
import { setContext } from '@apollo/client/link/context'
import store from '@/store/Index'
import { onError } from "@apollo/client/link/error"
import { createToast } from 'mosha-vue-toastify'

const errorLink = onError(({ graphQLErrors }) => {
  if (graphQLErrors) {
    graphQLErrors.forEach(({ message }) =>
      createToast(message, {type: 'danger'})
    )
  }
})

const host = window.location.origin
const httpLink = createHttpLink({
  uri: `${host}/graphql`
})

const authLink = setContext((_, { headers }) => {
  const authToken = store.getters.getAccessToken

  return {
    headers: {
      ...headers,
      Authorization: authToken ? `Bearer ${authToken}` : undefined
    }
  }
})

const cache = new InMemoryCache()

export const apolloClient = new ApolloClient({
  link: from([errorLink, authLink.concat(httpLink)]),
  cache,
})
