<script>
import axios from 'axios'
import Town from './Town.vue'
import TypesDonor from './TypesDonor.vue'
import CategoryDonor from './CategoryDonor.vue'
import Phone from './Phone.vue'
import Donation from './Donation.vue'


export default {
  name: 'EditDonor',
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
    Phone,
    Donation
},
  data() {
    return {
      donors: {},
      mail: '',
    }
  },
  mounted() {
    this.getDonor()
    this.getMail()
  },
  methods: {
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
    getMail(){
      try{
        axios.get('http://localhost:3000/mail/donor/' + this.idDonor)
        .then(response => {
          this.mail = response.data[0]
          // console.log(this.mail)
        })
      } catch (error) {
        console.log(error)
      }
    },
    confirmAlert(){
      let erroresDiv = document.getElementById('errores')
      erroresDiv.innerHTML = ''
      let errores = []

      let nombre = document.getElementById('name').value
      let municipio = document.getElementById('municipio').value
      let colonia = document.getElementById('colonia').value
      if(colonia === 'Otro'){
        colonia = document.getElementById('otra_colonia').value
      }
      let organizacion = document.getElementById('gremio').value

      // TODO: CHECK HOW TO STORE THE CFDI FILE
      // let cfdi = document.getElementById('cfdi').value
      // console.log(cfdi)
      
      let tipos = document.getElementsByClassName('type-check')
      var tipo = []
      for (let i = 0; i < tipos.length; i++) {
        if(tipos[i].checked){
          tipo.push(tipos[i].value)
        }
      }
      
      // Convert to json structure "id": "value"
      for(let i = 0; i < tipo.length; i++){
        tipo[i] = JSON.parse(`{"id": "${tipo[i]}"}`)
      }
      
      if(nombre === '' && organizacion === ''){
        errores.push('* Al menos debes llenar el nombre u organización')
      }
      if(municipio === ''){
        errores.push('* Debes seleccionar un municipio')
      }
      let mail = document.getElementById('email').value
      
      if(mail !== ''){
        console.info('Validate email')
        if(this.validateEmail(mail)){
          errores.push('* El correo no es valido')
        }
      }
      if(errores.length > 0){
        this.$swal({
          title: 'Error',
          text: 'Porfavor, llena los campos obligatorios',
          icon: 'error',
          confirmButtonText: 'Ok'
        })

        for(let i = 0; i < errores.length; i++){
          erroresDiv.innerHTML += `<p>${errores[i]}</p>`
        }
        return
      }

      let _category = document.querySelector('input[name="categoria"]:checked').value
      let web1 = document.getElementById('web1').value
      let web2 = document.getElementById('web2').value

      let data = {
        id: this.idDonor,
        name: nombre,
        city: municipio,
        colony: colonia,
        organization: organizacion,
        website1: web1,
        website2: web2,
        cfdi: null,
        type: tipo,
        category: _category,
        mail: mail
      }

      // CONVERT TO JSON
      let json = JSON.stringify(data)
      // console.log(json)
      

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
          this.updateDonor(json)
          this.$swal({
            title: '¡Agregado!',
            text: 'El donador ha sido actualizado.',
            icon: 'success',
            confirmButtonText: 'Ok'
          }).then((result)=>{
            if(result.isConfirmed){                        
              location.reload()
            }
          })
        }
      })
    },
    updateDonor(data){
      console.log(data)
      try{
        axios.put('http://localhost:3000/donor', data, {
          headers: {
            'Content-Type': 'application/json'
          }
        })
        .then(response => {
          console.log(response)
        })
      } catch (error) {
        console.log(error)
      }
    },
    validateEmail(mail){
      let validEmail = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
      console.log(mail.match(validEmail))
      return mail.match(validEmail) ? false : true
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
            <label class="form-label mt-2">Categoria</label>
            <CategoryDonor :category= donor.category_id />
            <label for="cfdi" class="form-label mt-2">CFDI</label>
            <input type="file" class="form-control modalInputText" name="cfdi" id="cfdi" accept=".pdf">
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
            <input v-if="this.mail != undefined || this.mail != null" class="form-control mb-3" type="email" name="email" id="email" :value="this.mail['donor_mail']">
            <input v-else class="form-control mb-3" type="email" name="email" id="email">
            <label for="web1">Website 1</label>
            <input class="form-control mb-3" type="text" name="web1" id="web1" :value="donor.donor_website1">
            <label for="web2">Website 2</label>
            <input class="form-control mb-3" type="text" name="web2" id="web2" :value="donor.donor_website2">
          </div>
        </form>
      </div>
      <div class="col-6">
        <h2 class="text-center">Donaciones</h2>
          <span v-for="donor in donors" :key="donor.donor_id">
            <Donation :idDonor = donor.donor_id />
        </span>
      </div>
    </div>
    <div class="row errores" id="errores"></div>
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
.errores{
  color: #dc3545
}
</style>