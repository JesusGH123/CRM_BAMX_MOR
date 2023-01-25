<script>
import axios from 'axios'
import AddProduct from '../components/AddProduct.vue';

export default {
    name: "Product",
    props: {
        title: String
    },
    components: {
        AddProduct
    },
    data() {
        return {
            products: {},
            filtered: Boolean
        };
    },
    mounted() {
        this.getProducts();
    },
    methods: {
        deleteProduct(idProduct){
            try {
                // axios.delete('http://localhost:3000/product/' + idProduct)
                axios.delete(this.$hostname + '/product/' + idProduct)
                .then(response => {
                    console.log(response)
                })
            } catch (error) {
                console.log(error)
            }
        },
        getProducts() {
            try {
                // axios.get("http://localhost:3000/product")
                axios.get(this.$hostname + "/product")
                    .then(response => {
                    this.products = response.data;

                    if(this.filtered === true){
                      let busqueda = document.getElementById("busqueda").value;
                      try {
                          // axios.get("http://localhost:3000/product/search/" + busqueda)
                          axios.get(this.$hostname + "/product/search/" + busqueda)
                              .then(response => {
                              this.products = response.data[0];
                              // console.log(this.products)
                          });
                      }
                      catch (error) {
                          console.log(error);
                      }
                    }
                });
            }
            catch (error) {
                console.log(error);
            }
        },
        deleteAlert(id) {
            this.$swal({
                title: "¿Estas segur(a)?",
                text: "No podrás revertir esto!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Si"
            }).then((result) => {
                if (result.isConfirmed) {
                    this.deleteProduct(id);
                    this.$swal({
                        title: "¡Eliminado!",
                        text: "El producto ha sido eliminado.",
                        icon: "success",
                        confirmButtonText: "Ok"
                    }).then((result)=>{
                      if(result.isConfirmed){                        
                        location.reload()
                      }
                    })
                }
            });
        },
        capitalize(data){
            return data.charAt(0).toUpperCase() + data.slice(1)
        },
        filterProducts(){
          event.preventDefault()
          let search = document.getElementById("busqueda").value
          if(search === ""){
            this.filtered = false
            this.getProducts()
            return
          } else{
            this.filtered = true
            this.getProducts()
            return
          }
        }
    }
}
</script>

<template>
<div class="row" v-if="this.title !== undefined">
  <div class="col-2 d-flex justify-content-center align-items-center">
    <AddProduct />
  </div>
  <div class="col-7 d-flex justify-content-center">
    <h1>{{ this.title }}</h1>
  </div>
  <div class="col-3 d-flex justify-content-center align-items-center">
    <form action="" style="margin-top: 10px;" autocomplete="off">
      <input autocomplete="false" hidden type="text" style="display:none;">
      <input type="text" placeholder="Buscar"  id="busqueda">
      <button type="submit" class="btn search_btn" style="margin-left: 10px;" @click="filterProducts">
        <img src="../assets/search.png" alt="search_icon" width="16" height="16" style="padding:0; margin:0;">
      </button>
    </form>
  </div>
</div> 
<div class="row m-3" v-else>
  <div class="col-3 d-flex justify-content-center align-items-center">
    <AddProduct />
  </div>
  <div class="col-6 d-flex justify-content-center"></div>
  <div class="col-3 d-flex justify-content-center align-items-center">
    <form action="" style="margin-top: 10px;" autocomplete="off">
      <input autocomplete="false" hidden type="text" style="display:none;">
      <input type="text" placeholder="Buscar"  >
      <button class="btn search_btn" style="margin-left: 10px;"><img src="../assets/search.png" alt="search_icon" width="16" height="16" style="padding:0; margin:0;"></button>
    </form>
  </div>
</div> 
<div class="row" >
  <table style="width:80%; margin: 0 auto;">
    <thead>
      <tr>
        <th>Nombre</th>
        <!-- <th>Eliminar</th> -->
      </tr>
    </thead>
    <tbody>
      <tr v-for="product in products" :key="product.product_id" class="fila">
        <td>
          {{ capitalize(product.product_name) }}
        </td>
        <!-- <td>
          <button class="btn delete" :id="'product_'+product.product_id" @click="deleteAlert(product.product_id)"><img src="../assets/trash.png" title="deleteImage" width="16" height="16"/></button>
        </td> -->
      </tr>
    </tbody>
  </table>
</div>
</template>

<style>
tr {
  text-align: center;
}
button{
  padding: 8px 10px !important;
}
button:hover.delete {
  background-color:rgba(239, 12, 12, 0.25) !important;
}
.fila:hover {
  background-color: rgba(200, 200, 200, 0.5) !important;
}
</style>
