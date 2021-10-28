import { reactive } from 'vue'

const state = reactive({
  user: {},
  authToken: null
})

const getters = {
  user: (state: any) => state.user,
  getAccessToken: (state: any) => state.authToken,
  isAuthenticated: (state: any) => !!state.authToken,
}

const mutations = {
  resetAllState(state: any) {
    state.user = {}
    state.authToken = null
  },
  setUser(state: any, user: {}) {
    state.user = user
  },
  setAuthToken(state: any, authToken: {}) {
    state.authToken = authToken
  }
}

const actions = {
  logOut: ({ commit }: any) => commit('resetAllState'),
  setUser: ({ commit }: any, client: {}) => commit('setUser', client),
  setAuthToken: ({ commit }: any, authToken: any) => commit('setAuthToken', authToken),
}

export default { state, getters, mutations, actions };
