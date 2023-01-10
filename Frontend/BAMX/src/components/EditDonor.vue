<script>
import axios from 'axios'
import Town from './Town.vue'
import TypesDonor from './TypesDonor.vue'
import CategoryDonor from './CategoryDonor.vue'
import Phone from './Phone.vue'


export default {
  name: 'Donors',
  props: {
    idDonor: {
      type: String,
      required: true
    }
  },
  components: {
    Town,
    TypesDonor,
    CategoryDonor,
    Phone
  },
  data() {
    return {
      donors: {},
      phones: {}
    }
  },
  mounted() {
    this.getDonor()
    this.getPhones()
  },
  methods: {
    deletePhone(idPhone){
      try {
        axios.delete('http://localhost:3000/phone/' + idPhone)
        .then(response => {
          console.log(response)
        })
      } catch (error) {
        console.log(error)
      }
    },
    getDonor() {
      try{
        axios.get('http://localhost:3000/donor/' + this.idDonor)
        .then(response => {
          this.donors = response.data[0]
          // console.log(this.donors)
          // console.log(this.idDonor)
        })
      } catch (error) {
        console.log(error)
      }
    },
    getPhones() {
      try{
        axios.get('http://localhost:3000/phone/' + this.idDonor)
        .then(response => {
          this.phones = response.data
          console.log(this.phones)
          // console.log(this.idDonor)
        })
      } catch (error) {
        console.log(error)
      }
    },
    deleteAlert(id){
      event.preventDefault() // prevent form submit
      this.$swal({
                title: "¿Estas seguro(a)?",
                text: "No podrás revertir esto!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Si"
            }).then((result) => {
                if (result.isConfirmed) {
                  this.deletePhone(id)
                  this.$swal({
                    title: "¡Borrado!",
                    text: "El registro ha sido borrado.",
                    icon: "success"
                  }).then((result) => {
                    if (result.isConfirmed) {
                      location.reload()
                    }
                  })
                }else
                  this.$swal("¡Cancelado!", "El registro no ha sido borrado.", "error");
            });
    },
    confirmAlert(){
      this.$swal({
        title: "¿Estas seguro(a)?",
        text: "El registro se modificara permanentemente",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Si"
      }).then((result) => {
        if (result.isConfirmed) {
          this.$swal("¡Modificado!", "El registro ha sido modificado.", "success");
        }
      })
    }

  }
}
</script>

<template>
  <h1>Editar usuario</h1>
  <div class="container">
    <div class="row">
      <div class="col-6">
        <h2 class="text-center">Informaci&oacute;n</h2>
        <form>
          <div v-for="donor in donors" :key="donor.donor_id">
            <label for="name" class="form-label">Nombre</label>
            <input class="form-control mb-3" type="text" name="name" id="name" :value="donor.donor_name">
            <label for="city" class="form-label">Ubicacion</label>
            <Town :municipio = donor.donor_city :colonia=donor.donor_colony />
            <label for="gremio" class="form-label">Organizaci&oacute;n / Gremio</label>
            <input class="form-control mb-3" type="text" name="gremio" id="gremio" :value="donor.donor_organization">
            <label class="form-label">Tipo de aliado</label>
            <TypesDonor :type= donor.Tipo />
            <label class="form-label">Categoria</label>
            <CategoryDonor :category= donor.Categoria />
          </div>
        </form>
      </div>
      <div class="col-6">
        <h2 class="text-center">Tel&eacute;fonos</h2>
        <span v-for="donor in donors" :key="donor.donor_id">
          <Phone :idDonor = donor.donor_id />
        </span>
      </div>
    </div>
    <div class="row d-flex mt-3">
      <div class="col-6">
        <h2 class="text-center">Contacto</h2>
        <form>
          <div v-for="donor in donors" :key="donor.donor_id">
            <label for="email" class="form-label">Correo</label>
            <input class="form-control mb-3" type="email" name="email" id="email" :value="donor.donor_email">
            <label for="web1">Website 1</label>
            <input class="form-control mb-3" type="text" name="web1" id="web1" :value="donor.donor_website1">
            <label for="web2">Website 2</label>
            <input class="form-control mb-3" type="text" name="web2" id="web2" :value="donor.donor_website2">
          </div>
        </form>
      </div>
      <div class="col-6">
        <h2 class="text-center">Productos</h2>
        <form class="limited-form">
          <label for="product" class="form-label">Producto</label>
          <input class="form-control mb-3" type="text" name="product" id="product">
          <label for="quantity" class="form-label">Cantidad</label>
          <input class="form-control mb-3" type="text" name="quantity" id="quantity">
          <label for="unit" class="form-label">Unidad</label>
          <input class="form-control mb-3" type="text" name="unit" id="unit">
          <label for="price" class="form-label">Precio</label>
          <input class="form-control mb-3" type="text" name="price" id="price">
          <label for="description" class="form-label">Descripci&oacute;n</label>
          <input class="form-control mb-3" type="text" name="description" id="description">
        </form>
      </div>
    </div>
    <div class="row">
        <div class="text-center">
          <button class="btn btn-success m-2" @click="confirmAlert()">Guardar</button>   
          <router-link to="/home">
            <button class="btn btn-danger m-2">Cancelar</button>
          </router-link>       
        </div>
      </div>
    <div class="row"></div>
  </div>
 
</template>

<style>
.limited-form{
  min-height: 340px;
  max-height: 340px;
  overflow-y: scroll;
  padding: 0 20px;
}
</style>