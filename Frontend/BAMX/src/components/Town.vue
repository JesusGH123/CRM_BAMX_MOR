<script>
import towns_data from '../assets/municipios_morelos.json'

export default {
  name: 'Town',
  data() {
    return {
      municipalities: towns_data,
      colonias: {},
      municipio: '',
      colonia: ''

    }
  },
  methods: {
    getTowns(i) {
      this.municipio = this.municipalities[i].Municipio
      this.colonias = this.municipalities[i].Colonias
    }
  }
}
</script>

<template>
  <div class="row">
    <div class="col">
      <div class="dropdown">
        <button class="btn btn-secondary dropdown-toggle" type="button" id="municipalitiesDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          Municipio: {{municipio}}
        </button>
        <ul class="dropdown-menu" aria-labelledby="municipalitiesDropdown">
          <li v-for="(municipio, i) in municipalities" :key="i" @click="getTowns(i)">
            {{municipio.Municipio}}
          </li>
        </ul>
      </div>
    </div>
    
    <div class="col">
      <div class="dropdown">
        <button v-if="this.municipio !== ''" class="btn btn-secondary dropdown-toggle" type="button" id="townsDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          Colonia: {{colonia}}
        </button>
        <ul v-if="this.municipio !== ''" class="dropdown-menu" aria-labelledby="townsDropdown">
          <li v-for="(colonia, i) in colonias" :key="i" @click="this.colonia = colonias[i]">
            {{colonia}}
          </li>
        </ul>
      </div>    
    </div>

  </div>
</template>

<style>
li {
  padding: 0 10px;
  cursor: pointer;
}
li:hover {
  background-color: #ccc;
}
.dropdown-menu {
  max-height: 300px;
  overflow-y: auto;
}
</style>