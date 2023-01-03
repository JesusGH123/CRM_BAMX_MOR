<script setup>
import Donor from '../components/Donor.vue'
</script>

<template>
  <main>
    <div class="container">
      <h1>Donadores</h1>
      <button type="button" class="btn btn-warning">Agregar donador</button>
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
</style>