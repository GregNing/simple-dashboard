import { ApolloClient, createHttpLink, InMemoryCache } from '@apollo/client/core'
import { setContext } from '@apollo/client/link/context'
import { getStoredAuthToken } from '@/utils/authToken'

const host = window.location.origin
const httpLink = createHttpLink({
  uri: `${host}/graphql`
})

const authLink = setContext((_, { headers }) => {
  const authToken = getStoredAuthToken()

  return {
    headers: {
      ...headers,
      Authorization: authToken ? `Bearer ${authToken}` : undefined
    }
  }
})

// Cache implementation
const cache = new InMemoryCache()

// Create the apollo client
export const apolloClient = new ApolloClient({
  link: httpLink,
  cache,
})