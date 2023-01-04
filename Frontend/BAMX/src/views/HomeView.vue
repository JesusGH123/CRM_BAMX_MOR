<script setup>
import Donor from '../components/Donor.vue'
</script>

<template>
  <main>
    <div class="container">
      <div class="row">
        <div class="col-2 d-flex justify-content-center align-items-center">
          <button class="btn btn-warning" >Agregar donador</button>
        </div>
        <div class="col-7">
          <h1>Donadores</h1>
        </div>
        <div class="col-3 d-flex justify-content-center align-items-center">
          <form action="" style="margin-top: 10px;">
            <input type="text" placeholder="Buscar"  >
            <button class="btn btn-primary" style="margin-left: 10px;">Buscar</button>
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
</style>