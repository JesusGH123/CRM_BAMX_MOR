<script>
import axios from 'axios'

export default {
    name: "Donors",
    data() {
        return {
            donors: {},
            categorias: {},
            types: {}
        };
    },
    mounted() {
        this.getDonors();
        this.getTypes();
        this.getCategorias();
    },
    methods: {
        getCategorias() {
            axios.get("http://localhost:3000/categories")
                .then(response => {
                    this.categorias = response.data;
                })
                .catch(error => {
                    console.log(error);
                });
        },
        getTypes() {
            axios.get("http://localhost:3000/types")
                .then(response => {
                    this.types = response.data;
                })
                .catch(error => {
                    console.log(error);
                });
        },
        deleteDonor(idDonor){
            try {
                axios.delete('http://localhost:3000/donor/' + idDonor)
                .then(response => {
                    console.log(response)
                })
            } catch (error) {
                console.log(error)
            }
        },
        getDonors() {
            try {
                axios.get("http://localhost:3000/")
                    .then(response => {
                    this.donors = response.data;
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
        }
    }
}
</script>

<template>
  <tr v-for="donor in donors" :key="donor.donor_id" class="fila">
    <div hidden></div>
    <td>{{ donor.donor_name }}</td>
    <td>{{ donor.donor_city }}</td>
    <td>{{ donor.donor_colony }}</td>
    <td>{{ donor.donor_organization }}</td>
    <td> 
      <div v-for="tipo in types" :key="tipo.type_id">
        <span v-if="donor.Tipo.includes(tipo.type_id)">{{tipo.type_name}}</span>
      </div>
    </td>
    <td>{{ donor.donor_website1 }} <br> {{ donor.donor_website2 }}</td>
    <td>
      <!-- {{ categorias }} -->
      <div v-for="categoria in categorias" :key="categoria.cat_id">
        <span v-if="donor.category_id == categoria.cat_id">{{categoria.cat_name}}</span>
      </div>
    </td>
    <td>
      <button v-if="donor.donor_cfdi != NULL" class="btn download" :id="donor.donor_id" @click="descargar(donor.donor_id)"><img src="../assets/download.png" title="descargar_cfdi" width="16"></button>
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
