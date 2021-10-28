import { createRouter, createWebHistory } from 'vue-router'
import { map, extend } from 'lodash'
import store from '@/store'
import SignUp from '@/components/Pages/SignUp.vue'
import LognIn from '@/components/Pages/LognIn.vue'
import Dashboard from '@/components/Pages/Dashboard.vue'

let routes = [
  {
    path: '/dashboard',
    name: 'Dashboard',
    meta: { requiresAuth: true },
    component: Dashboard,
  },
  {
    path: '/lognin',
    name: 'Lognin',
    component: LognIn,
  },
  {
    path: '/signup',
    name: 'SignUp',
    component: SignUp,
  },
];

routes = map(routes, (route: any) => {
  return extend({}, route, { props: true })
})

const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach(async (to, _, next) => {
  const isAuthenticated = store.getters.isAuthenticated

  if (to.matched.some(routeRecord => routeRecord.meta.requiresAuth) && !isAuthenticated) next({ name: 'Lognin' })
  else if (!to.matched.some(routeRecord => routeRecord.meta.requiresAuth) && isAuthenticated) next({ name: 'Dashboard' })
  else next()
})

export default router
