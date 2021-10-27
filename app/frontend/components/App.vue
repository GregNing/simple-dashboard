<template>
  <div>
    <div class="wrapper">
      <Navigation></Navigation>
      <main class="container content">
        <div class="row">
          <div class="col-md-10 offset-md-1">
            <router-view/>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<script lang="ts">
import Navigation from './Layouts/Navigation.vue';

export default {
  name: 'ApplicationRootComponent',
  components: { Navigation }
};
</script>
