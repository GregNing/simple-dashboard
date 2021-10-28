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
              :to="{ name: 'Lognin' }"
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

export default {
  name: 'Navbar',
  components: { ThirdpartyLogin },
  setup() {
    const { getters } = useStore()
    const isAuthenticated = computed(() => getters.isAuthenticated)
    const name = computed(() => getters.user.name)
    const handleLogOut = async () => {

    }
    return {
      isAuthenticated,
      name,
      handleLogOut
    };
  },
};
</script>
