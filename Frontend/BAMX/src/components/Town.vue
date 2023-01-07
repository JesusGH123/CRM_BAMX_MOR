<script>
import towns_data from '../assets/municipios_morelos.json'

export default {
  name: 'Town',
  props: {
    municipio: String,
    colonia: String
  },
  data() {
    return {
      municipalities: towns_data,
      colonias: {},
      _municipio: '',
      _colonia: '',
      start: true
    }
  },
  methods: {
    initData(){
      if(this.start){
        // console.log(this.municipio)
        // console.log(this.colonia)
        this.start = false
        if(this.municipio !== undefined){
          this.getTowns(this.municipalities.findIndex(municipio => municipio.Municipio === this.municipio))
          if(this.colonia !== undefined)
            this._colonia = this.colonia
          // Search the index of the element given the value of the property
        }
      }
    },
    getTowns(i) {
      this._municipio = this.municipalities[i].Municipio
      this._colonia = ''
      this.colonias = this.municipalities[i].Colonias
      this.colonias = this.colonias.sort()
      if(!this.colonias.includes('Otro'))
        this.colonias.push('Otro')
    }
  }
}
</script>

<template>
  <div class="row">
    {{ initData() }}
    <div class="col">
      <div class="dropdown">
        <button class="btn dropdown-toggle" type="button" id="municipalitiesDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          Municipio: {{this._municipio}}
        </button>
        <ul class="dropdown-menu" aria-labelledby="municipalitiesDropdown">
          <li class="ciudad" v-for="(municipio, i) in municipalities" :key="i" @click="getTowns(i)">
            {{municipio.Municipio}}
          </li>
        </ul>
      </div>
    </div>
    
    <div class="col">
      <div class="dropdown">
        <button v-if="this._municipio !== ''" class="btn dropdown-toggle" type="button" id="townsDropdown" data-bs-toggle="dropdown" aria-expanded="false">
          Colonia: {{_colonia}}
        </button>
        <ul v-if="this._municipio !== ''" class="dropdown-menu" aria-labelledby="townsDropdown">
          <li class="ciudad" v-for="(colonia, i) in colonias" :key="i" @click="this._colonia = colonias[i]">
            {{colonia}}
          </li>
        </ul>
      </div>    
    </div>

    <div v-if="this._colonia === 'Otro'" class="col">
      <input type="text" name="otra_colonia" id="otra_colonia" placeholder="Escribe la colonia">
    </div>

    <div>
      <input type="text" name="municipio" id="municipio" :value="this._municipio" hidden>
      <input type="text" name="colonia" id="colonia" :value="this._colonia" hidden>
    </div>

  </div>
</template>

<style>
.ciudad {
  padding: 0 10px;
  cursor: pointer;
}
.ciudad:hover {
  background-color: #ccc;
}
.dropdown-menu {
  max-height: 300px;
  overflow-y: auto;
}
</style>