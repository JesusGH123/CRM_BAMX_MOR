<script setup>
import Donor from '../components/Donor.vue'
import AddDonor from '../components/AddDonor.vue'
</script>

<template>
  <main>
    <div class="container">
      <div class="row">
        <div class="col-2 d-flex justify-content-center align-items-center">
          <AddDonor />
        </div>
        <div class="col-7 d-flex justify-content-center">
          <h1>Donadores</h1>
        </div>
        <div class="col-3 d-flex justify-content-center align-items-center">
          <form action="" style="margin-top: 10px;" autocomplete="off">
            <input autocomplete="false" hidden type="text" style="display:none;">
            <input type="text" placeholder="Buscar"  >
            <button class="btn search_btn" style="margin-left: 10px;"><img src="../assets/search.png" alt="search_icon" width="16" height="16" style="padding:0; margin:0;"></button>
          </form>
        </div>
      </div>
      <table style="width:100%">
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Ciudad</th>
            <th>Colonia</th>
            <th>Organizaci&oacute;n/Gremio</th>
            <th>Tipo de aliado</th>
            <th>Sitio[s] web</th>
            <th>Categor&iacute;a</th>
            <th>CFDI</th>
          </tr>
        </thead>
        <tbody>
          <Donor />
        </tbody>
      </table>
    </div>
  </main>
</template>

<style>
h1{
  text-align: center;
  padding: 10px 0;
  font-style: italic;
}

button, input{
  display: inline-block;
}

input[type=text]{
  border-radius: 5px;
  outline: 0;
  border-width: 0 0 2px;
  border-color: #c2c2c2;
  padding: 5px 10px;
  min-height: 42px;
  max-height: 42px;
}

.search_btn{
  border-radius: 50px;
  background-color: rgba(255,0,0,0.3) !important;
}

.search_btn:hover{
  background-color: rgba(255,0,0,0.5) !important;
}
</style>