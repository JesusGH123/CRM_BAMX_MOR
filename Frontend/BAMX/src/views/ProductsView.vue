<script setup>
import AddProduct from '../components/AddProduct.vue';
import Product from '../components/Product.vue';
</script>

<template>
  <div class="container">
    <div class="row">
      <div class="col-2 d-flex justify-content-center align-items-center">
        <AddProduct />
      </div>
      <div class="col-7 d-flex justify-content-center">
        <h1>Productos</h1>
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
          <th style="width:80%;">Nombre</th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <Product />
      </tbody>
    </table>
  </div>
</template>

<style>

</style>
