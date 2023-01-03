<script setup>
</script>

<template>
  <main>
    <div class="container m-5">
      <img class="img_portada" src="../assets/bamx-logo-removebg.png" alt="bamx_logo">
    </div>
    <router-link to="/home" class="btn_home">Ingresar</router-link>
  </main>
</template>

<style>
.img_portada{
  display: block;
  margin-left: auto;
  margin-right: auto;
}

.btn_home{
  border-radius: 50px;
  background-color: #EA2040;
  color: white;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;

  position: absolute;
  left: 50%;
}

.btn_home:hover{
  background-color: #EA2040;
  color: #ccc;
  text-decoration: none;
}
</style>