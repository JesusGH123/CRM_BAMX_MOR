<script>
import axios from 'axios'
import AddDonor from './AddDonor.vue';

export default {
    name: "Donors",
    data() {
        return {
            donors: {},
            filteredDonors: {},          
            categorias: {},
            types: {},
            products: {},
            filtered: Boolean
        };
    },
    props: {
        title: String
    },
    components: {
        AddDonor
    },
    mounted() {
        this.getDonors();
        this.getTypes();
        this.getCategorias();
        this.getProducts();
    },
    methods: {
        getProducts() {
            // axios.get("http://localhost:3000/product")
            axios.get(this.$hostname + "/product")
                .then(response => {
                    this.products = response.data;                    
                })
                .catch(error => {
                    console.log(error);
                });
        },
        getCategorias() {
            // axios.get("http://localhost:3000/categories")
            axios.get(this.$hostname + "/categories")
                .then(response => {
                    this.categorias = response.data;
                })
                .catch(error => {
                    console.log(error);
                });
        },
        getTypes() {
            // axios.get("http://localhost:3000/types")
            axios.get(this.$hostname + "/types")
                .then(response => {
                    this.types = response.data;
                })
                .catch(error => {
                    console.log(error);
                });
        },
        deleteDonor(idDonor){
            try {
                // axios.delete('http://localhost:3000/donor/' + idDonor)
                axios.delete(this.$hostname + '/donor/' + idDonor)
                .then(response => {
                    console.log(response)
                })
            } catch (error) {
                console.log(error)
            }
        },
        getDonors() {
          if(this.filtered === true){
            let search = document.getElementById("busqueda").value
            try {
                // axios.get("http://localhost:3000/donorFiltered", {
                axios.get(this.$hostname + "/donorFiltered", {
                    params: {
                        search: search
                    }})
                    .then(response => {
                    this.filteredDonors = response.data[0];
                    // console.log(this.filteredDonors)
                    let ids = this.filteredDonors.map(donor => donor.donor_id)
                    // console.log(ids)

                    this.donors = this.donors.filter(donor => ids.includes(donor.donor_id))
                    // console.log(this.donors)                    
                });
            }
            catch (error) {
                console.log(error);
            }
            return
          } else {
            try {
                // axios.get("http://localhost:3000/")
                axios.get(this.$hostname)
                    .then(response => {
                    this.donors = response.data[0];
                });
            }
            catch (error) {
                console.log(error);
            }
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
                    this.deleteDonor(id);
                    this.$swal({
                        title: "¡Eliminado!",
                        text: "El donador ha sido eliminado.",
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
        filterDonors(){
          event.preventDefault()
          let search = document.getElementById("busqueda").value
          if(search === ""){
            this.filtered = false
            this.getDonors()
            return
          } else{
            this.filtered = true
            this.getDonors()
            return
          }
        },
        downloadFile(name){
          window.open(this.$hostname + "/upload/" + name, '_blank')
        }
    }
}
</script>

<template>
  <div class="row" v-if="this.title !== undefined">
    <div class="col-2 d-flex justify-content-center align-items-center">
      <AddDonor />
    </div>
    <div class="col-7 d-flex justify-content-center">
      <h1>{{ this.title }}</h1>
    </div>
    <div class="col-3 d-flex justify-content-center align-items-center">
      <form style="margin-top: 10px;" autocomplete="off">
        <input autocomplete="false" hidden type="text" style="display:none;">
        <input type="text" placeholder="Buscar" id="busqueda" >
        <button type="submit" class="btn search_btn" style="margin-left: 10px;" @click="filterDonors">
          <img src="../assets/search.png" alt="search_icon" width="16" height="16" style="padding:0; margin:0;">
        </button>
      </form>
    </div>
  </div>
  <div class="row m-3" v-else>
    <div class="col-3 d-flex justify-content-center align-items-center">
      <AddDonor />
    </div>
    <div class="col-6"></div>
    <div class="col-3 d-flex justify-content-center align-items-center">
      <form style="margin-top: 10px;" autocomplete="off">
        <input autocomplete="false" hidden type="text" style="display:none;">
        <input type="text" placeholder="Buscar" id="busqueda" >
        <button class="btn search_btn" style="margin-left: 10px;">
          <img src="../assets/search.png" alt="search_icon" width="16" height="16" style="padding:0; margin:0;">
        </button>
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
      <th>Productos</th>
      <th>Categor&iacute;a</th>
      <th>CFDI</th>
    </tr>
  </thead>
  <tbody>

  <tr v-for="donor in donors" :key="donor.donor_id" class="fila">
    <div hidden></div>
    <td>{{ donor.donor_name }}</td>
    <td>{{ donor.donor_city }}</td>
    <td>{{ donor.donor_colony }}</td>
    <td>{{ donor.donor_organization }}</td>
    <td> 
      <div v-if="donor.Tipo !== null" v-for="tipo in types" :key="tipo.type_id">
        <span v-if="donor.Tipo.includes(tipo.type_id)">{{tipo.type_name}}</span>
      </div>
    </td>
    <td> 
      <div v-if="donor.Donations !== null" v-for="product in products" :key="product.product_id">
        <span v-if="donor.Donations.includes(product.product_id)">{{capitalize(product.product_name)}}</span>
      </div>
    </td>
    <td>
      <!-- {{ categorias }} -->
      <div v-for="categoria in categorias" :key="categoria.cat_id">
        <span v-if="donor.category_id == categoria.cat_id">{{categoria.cat_name}}</span>
      </div>
    </td>
    <td>
      <button v-if="donor.donor_cfdi != NULL" class="btn download" :id="donor.donor_id" @click="downloadFile(donor.donor_cfdi)"><img src="../assets/download.png" title="descargar_cfdi" width="16"></button>
      <button v-else class="btn download" :id="donor.donor_id" disabled style="border: none"><img src="../assets/download.png" title="descargar_cfdi" width="16"></button>
    </td>
    
    <td>
      <router-link :to="{name: 'edit', params:{id: donor.donor_id}}">
        <button class="btn update" :id="donor.donor_id"><img src="../assets/pencil.png" title="editImage" width="16" height="16"/></button>
      </router-link>
    </td>
    <td>
      <button class="btn delete" :id="donor.donor_id" @click="deleteAlert(donor.donor_id)"><img src="../assets/trash.png" title="deleteImage" width="16" height="16"/></button>
    </td>
  </tr>
  </tbody>
</table>
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

h1{
  text-align: center;
  padding: 10px 0;
  font-style: italic;
}

button, input{
  display: inline-block;
}

input[type=text], 
input[type=email],
input[type=number]{
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

td{
  padding: 10px 0;
  max-width: 200px;
}

</style>
