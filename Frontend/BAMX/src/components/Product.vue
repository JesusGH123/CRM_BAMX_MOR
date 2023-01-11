<script>
import axios from 'axios'

export default {
    name: "Product",
    data() {
        return {
            products: {}
        };
    },
    mounted() {
        this.getProducts();
    },
    methods: {
        deleteProduct(idProduct){
            try {
                axios.delete('http://localhost:3000/donor/' + idProduct)
                .then(response => {
                    console.log(response)
                })
            } catch (error) {
                console.log(error)
            }
        },
        getProducts() {
            try {
                axios.get("http://localhost:3000/product")
                    .then(response => {
                    this.products = response.data[0];
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
        }
    }
}
</script>

<template>
  <tr v-for="product in products" :key="product.donor_id" class="fila">
    <div hidden></div>
    <td>
      <router-link :to="{name: 'edit', params:{id: product.donor_id}}">
        <button class="btn update" :id="product.donor_id"><img src="../assets/pencil.png" title="editImage" width="16" height="16"/></button>
      </router-link>
    </td>
    <td>
      <button class="btn delete" :id="product.donor_id" @click="deleteAlert(product.donor_id)"><img src="../assets/trash.png" title="deleteImage" width="16" height="16"/></button>
    </td>
  </tr>
</template>

<style>
tr {
  text-align: center;
}
button{
  padding: 8px 10px !important;
}
button:hover.update {
  background-color: rgba(0, 0, 200, 0.25) !important;
}
button:hover.delete {
  background-color:rgba(239, 12, 12, 0.25) !important;
}
button:hover.download {
  background-color: rgba(0, 200, 0, 0.25) !important;
}
.fila:hover {
  background-color: rgba(200, 200, 200, 0.5) !important;
}
</style>
