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
      axios.get('http://localhost:3000/types')
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
    <div class="col-6" v-for="tipo in this.tipos" :key="this.tipos.type_id">
        <div class="form-check">
          <input class="form-check-input type-check" type="checkbox" name="tipo" :id="tipo.type_id" :value="tipo.type_id">
          <label class="form-check-label" :for="tipo.type_id">{{tipo.type_name}}</label>
        </div>
    </div>
  </div>
</template>

<style>
</style>