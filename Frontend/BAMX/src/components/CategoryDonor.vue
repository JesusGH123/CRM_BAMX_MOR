<script>
import axios from 'axios'

export default {
  name: 'Category',
  props:{
    category: Number
  },
  data() {
    return {
      categorias: {},
      cantidad: 0,
      groups: 2
    }
  },
  mounted: function() {
    this.getTypes()
  },
  methods: {
    getTypes() {
      axios.get('http://localhost:3000/categories')
        .then(response => {
          this.categorias = response.data
          // console.log(this.categorias)
        })
        .catch(error => {
          console.log(error)
        })
    }
  }
}

</script>

<template>
  <div class="row">
    <div class="col-6" v-for="(categoria,i) in this.categorias" :key="this.categorias.cat_id">
        <div class="form-check">
          <input v-if="this.category === undefined && i == 0" checked class="form-check-input" type="radio" name="categoria" :id="categoria.cat_name" :value="categoria.cat_id">
          <input v-else-if="this.category === categoria.cat_id" checked class="form-check-input" type="radio" name="categoria" :id="categoria.cat_name" :value="categoria.cat_id">
          <input v-else  class="form-check-input" type="radio" name="categoria" :id="categoria.cat_name" :value="categoria.cat_id">
          <label class="form-check-label" :for="categoria.cat_name">{{categoria.cat_name}}</label>
        </div>
    </div>
  </div>
</template>

<style>
</style>