<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <div
        id="navbarSupportedContent"
        class="collapse navbar-collapse"
      >
        <ul
          class="navbar-nav"
        >
          <li class="nav-item">
            <router-link
              :to="{ name: 'signup' }"
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

export default {
  name: 'Navbar',
  components: { ThirdpartyLogin },
};
</script>
