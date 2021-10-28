<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <div
        id="navbarSupportedContent"
        class="collapse navbar-collapse"
      >
        <ul
          v-if="isAuthenticated"
          class="navbar-nav"
        >
          <li class="nav-item active">
            <span class="nav-link disabled">
              {{ name }}
            </span>
          </li>
          <li class="nav-item">
            <a
              class="nav-link"
              href="#"
              @click.prevent="handleLogOut"
            >
              Log out
            </a>
          </li>
          <li class="nav-item">
            <router-link
              :to="{ name: 'Dashboard' }"
              class="nav-link"
            >
              Dashboard
            </router-link>
          </li>
        </ul>
        <ul
          v-else
          class="navbar-nav"
        >
          <li class="nav-item">
            <router-link
              :to="{ name: 'LogIn' }"
              class="nav-link"
            >
              Sign In
            </router-link>
          </li>
          <li class="nav-item">
            <router-link
              :to="{ name: 'SignUp' }"
              class="nav-link"
            >
              Sign up
            </router-link>
          </li>
          <li>
            <ThirdpartyLogin />
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script lang="ts">
import ThirdpartyLogin from '@/components/Shared/ThirdpartyLogin.vue'
import { useStore } from 'vuex'
import { computed } from 'vue'
import { useMutation } from '@vue/apollo-composable'
import { LogOut } from '@/graphql/Queries/User'
import { useRouter } from 'vue-router'
import { createToast } from 'mosha-vue-toastify'
import _get from 'lodash/get'

export default {
  name: 'Navbar',
  components: { ThirdpartyLogin },
  setup() {
    const router = useRouter()
    const { getters, dispatch } = useStore()
    const isAuthenticated = computed(() => getters.isAuthenticated)
    const name = computed(() => getters.user.name)
    const { mutate: logOutMutation, loading: loading } = useMutation(LogOut)

    const handleLogOut = async () => {
      try {
        const result = await logOutMutation()
        let success = _get(result, 'data.logOut.success', false)

        if(success) {
          dispatch('logOut')
          localStorage.clear()
          createToast('Log Out Success')
          router.push({ name: 'LogIn' });
        }
      } catch (error) {
      }
    }
    return {
      isAuthenticated,
      name,
      handleLogOut
    };
  },
};
</script>
