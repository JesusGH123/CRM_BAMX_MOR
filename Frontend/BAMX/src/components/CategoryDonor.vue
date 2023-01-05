<script>
import axios from 'axios'

export default {
  name: 'Category',
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
      axios.get('http://localhost:3000/types')
        .then(response => {
          this.categorias = response.data
          console.log(this.categorias)
        })
        .catch(error => {
          console.log(error)
        })
    }
  },
  computed: {
    cantidadTipos() {
      console.log(this.categorias)
      this.cantidad = this.categorias.length
      console.log(this.cantidad)
      return this.cantidad
    }
  },
}

</script>

<template>
  <div class="row">
    <div class="col-6" v-for="(categoria,i) in this.categorias" :key="this.categorias.type_id">
        <div class="form-check">
          <input v-if="i == 0" checked  class="form-check-input" type="radio" name="tipo" :id="categoria.type_name" :value="categoria.type_id">
          <input v-else  class="form-check-input" type="radio" name="tipo" :id="categoria.type_name" :value="categoria.type_id">
          <label class="form-check-label" :for="categoria.type_name">{{categoria.type_name}}</label>
        </div>
    </div>
  </div>
</template>

<style>
</style>