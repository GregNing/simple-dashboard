import { createRouter, createWebHistory } from 'vue-router'
import { map, extend} from 'lodash'

import SignUp from '@/components/Pages/SignUp.vue'

let routes = [
  {
    path: '/signup',
    name: 'signup',
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

export default router