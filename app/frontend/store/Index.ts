import createPersistedState from 'vuex-persistedstate'
import auth from './modules/Auth'
import { createStore, createLogger } from 'vuex'
import SecureLS from "secure-ls"
var ls = new SecureLS({ isCompression: false });

export default createStore({
  modules: {
    auth,
  },
  plugins: [
    createLogger(),
    createPersistedState({
      key: 'simple-dashboard',
      storage: {
        getItem: (key) => ls.get(key),
        setItem: (key, value) => ls.set(key, value),
        removeItem: (key) => ls.remove(key)
      }
    })
  ]
})
