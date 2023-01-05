<script>
import axios from 'axios'

export default {
  name: 'Types',
  data() {
    return {
      tipos: {},
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
          this.tipos = response.data
        })
        .catch(error => {
          console.log(error)
        })
    }
  },
  computed: {
    cantidadTipos() {
      console.log(this.tipos)
      this.cantidad = this.tipos.length
      console.log(this.cantidad)
      return this.cantidad
    }
  },
}

</script>

<template>
  <div class="row">
    <div class="col-6" v-for="tipo in this.tipos" :key="this.tipos.cat_id">
        <div class="form-check">
          <input class="form-check-input type-check" type="checkbox" name="tipo" :id="tipo.cat_id" :value="tipo.cat_id">
          <label class="form-check-label" :for="tipo.cat_id">{{tipo.cat_name}}</label>
        </div>
    </div>
  </div>
</template>

<style>
</style>