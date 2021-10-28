<template>
  <div>
    <h1>This page is behind Auth</h1>
    <hr class="invisible" />
    <div v-if="isAuthenticated">
      <div>HELLO I'm Greg</div>
    </div>
    <div v-else>
      <h1>You are not signed in so you CANNOT View it!</h1>
    </div>
  </div>
</template>

<script lang="ts">
import { useStore } from "vuex"

export default {
  name: "Dashboard",
  setup() {
    const { getters } = useStore();
    const isAuthenticated = getters.isAuthenticated;

    return {
      isAuthenticated,
    };
  },
};
</script>
