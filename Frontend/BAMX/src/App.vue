<script>
import { RouterLink, RouterView } from 'vue-router'
import Header from './components/Header.vue'
// import Footer from './components/Footer.vue'

export default {
  name: 'App',
  components: {
    RouterLink,
    RouterView,
    Header
    // Footer
  },
  computed: {
    principal() {
      return this.$route.path !== '/'
    }
  }
}

</script>

<template>
  <Header v-if="principal"/>
  <RouterView />
  <!-- <Footer/> -->
</template>

<style scoped>

</style>
