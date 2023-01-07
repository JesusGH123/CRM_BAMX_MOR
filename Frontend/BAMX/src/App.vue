<script>
import { RouterLink, RouterView } from 'vue-router'
import Header from './components/structure/Header.vue'
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
  <main>
    <Header v-if="principal"/>
    <RouterView />
    <!-- <Footer/> -->
  </main>

</template>

<style scoped>

</style>
