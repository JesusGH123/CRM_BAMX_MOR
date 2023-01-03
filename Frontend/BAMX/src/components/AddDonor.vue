<script>
import axios from 'axios'

export default{
  name: 'AddDonor',
  methods:{
    addDonor(data){
      try{
        axios.post('http://localhost:3000/donor', data)
        .then(response => {
          console.log(response)
        })
      } catch (error) {
        console.log(error)
      }
    }
  }
}

</script>

<template>
<div class="container">
  <form>

  </form>
</div>
</template>

<style>
</style>