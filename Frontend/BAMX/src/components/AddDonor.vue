<script>
import axios from 'axios'
import Town from './Town.vue'
import TypeDonor from './TypesDonor.vue'
import CategoryDonor from './CategoryDonor.vue'

export default{
  name: 'AddDonor',
  data(){
    return {
      _cfdi: ''
    }
  },
  methods:{
    validatePhone: function(event){
      var theEvent = event || window.event;
      // Handle paste
      if (theEvent.type === 'paste') {
          key = event.clipboardData.getData('text/plain');
      } else {
      // Handle key press
          var key = theEvent.keyCode || theEvent.which;
          key = String.fromCharCode(key);
      }
      var regex = /[0-9]/;
      if( !regex.test(key) ) {
        theEvent.returnValue = false;
        if(theEvent.preventDefault) theEvent.preventDefault();
      }
    },
    addDonorAlert(){
      let erroresDiv = document.getElementById('errores')
      erroresDiv.innerHTML = ''
      let errores = []

      let nombre = document.getElementById('addDonorName').value
      let municipio = document.getElementById('municipio').value
      let colonia = document.getElementById('colonia').value
      if(colonia === 'Otro'){
        colonia = document.getElementById('otra_colonia').value
      }
      let organizacion = document.getElementById('addDonorOrganization').value

      // TODO: CHECK HOW TO STORE THE CFDI FILE
      // let cfdi = document.getElementById('addDonorCFDI').value
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

      let web1 = document.getElementById('addDonorWebsite1').value
      let web2 = document.getElementById('addDonorWebsite2').value
      let _category = document.querySelector('input[name="categoria"]:checked').value

      let data = {
        name: nombre,
        city: municipio,
        colony: colonia,
        organization: organizacion,
        website1: web1,
        website2: web2,
        cfdi: null,
        type: tipo,
        category: _category
      }

      // CONVERT TO JSON
      let json = JSON.stringify(data)
      
      this.$swal({
        title: 'Seguro que quieres agregar este donador?',
        text: 'No podrás revertir esto!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Si'
      }).then((result) => {
        if (result.isConfirmed) {
          this.addDonor(json)          
        }
      })
    },
    async addDonor(data){
      try{
        // await axios.post('http://localhost:3000/donor', data, {
        await axios.post(this.$hostname + '/donor', data, {
          headers: {
            'Content-Type': 'application/json'
          }
        })
        .then(response => {
          console.log(response)
          if( response['data'][0][0].RESULT !== 'ERROR!'){
            let id = response['data'][0][0].RESULT
            if(this._cfdi !== ''){
              // UPLOAD CFDI
              const formData = new FormData()
              formData.append('file', this._cfdi)
              console.log(formData)
              try {
                axios.post(this.$hostname + '/upload/' + id, formData, {
                  headers: {
                    'Content-Type': 'multipart/form-data'
                  }
                })
                .then(response => {
                  console.log(response)

                  this.$swal({
                    title: '¡Agregado!',
                    text: 'El donador ha sido agregado.',
                    icon: 'success',
                    confirmButtonText: 'Ok'
                  }).then((result)=>{
                    if(result.isConfirmed){                        
                      location.reload()
                    }
                  })
                })
              } catch(error) {
                console.log(error)
              }

            }

            this.$swal({
              title: '¡Agregado!',
              text: 'El donador ha sido agregado.',
              icon: 'success',
              confirmButtonText: 'Ok'
            }).then((result)=>{
              if(result.isConfirmed){                        
                location.reload()
              }
            })
          } else
            this.$swal({
              title: 'Oops!',
              text: 'Hubo un error.',
              icon: 'error',
              confirmButtonText: 'Ok'
            }).then((result)=>{
              if(result.isConfirmed){                        
                location.reload()
              }
            })

        })
      } catch (error) {
        console.log(error)
      }
      return
    },
    handleFile(e){
      this._cfdi = e.target.files[0]
      console.log(this._cfdi.type)
      if(this._cfdi.type !== 'application/pdf'){
        this.$swal({
          title: 'Error',
          text: 'El archivo debe ser un PDF',
          icon: 'error',
          confirmButtonText: 'Ok'
        })
        this._cfdi = ''
        let inputFile = document.getElementById('addDonorCfdi')
        inputFile.value = ''        
        return
      }
    }
  },
  components:{
    Town,
    TypeDonor,
    CategoryDonor
  }
}

</script>

<template>
<button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#addDonor">Agregar donador</button>

<!-- Modal -->
<div class="modal fade" id="addDonor" tabindex="-1" aria-labelledby="addDonorLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addDonorLabel">Agregar donador</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="">
          <div class="row d-flex align-items-center m-2">
            <label class="col-form-label col-sm-2" for="addDonorName">Nombre*</label>
            <div class="col-sm-10">
              <input type="text" class="form-control modalInputText" id="addDonorName" name="donorName">
            </div>
          </div>
          <div class="row d-flex align-items-center m-2">
            <label class="col-form-label col-sm-2">Ubicaci&oacute;n*</label>
            <div class="col-sm-10">
              <Town/>
            </div>
          </div>
          <div class="row d-flex align-items-center m-2">
            <label class="col-form-label col-sm-2" for="addDonorOrganization">Organizaci&oacute;n* </label>
            <div class="col-sm-10">
              <input type="text" class="form-control modalInputText" id="addDonorOrganization" name="donorOrganization">
            </div>
          </div>
          <div class="row d-flex align-items-center m-2">
              <label class="col-form-label col-sm-2">Tipo de aliado*</label>
            <div class="col-sm-10">
              <TypeDonor />
            </div>
          </div>
          <div class="row d-flex align-items-center m-2">
              <label class="col-form-label col-sm-2">Categoria*</label>
            <div class="col-sm-10">
              <CategoryDonor />
            </div>
          </div>
          <div class="row d-flex align-items-center m-2">
            <label for="addDonorWebsite1" class="col-sm-2">Sitio web 1</label>
            <div class="col-sm-10">
              <input type="text" class="form-control modalInputText" id="addDonorWebsite1" name="donorWebsite1">
            </div>
          </div>
          <div class="row d-flex align-items-center m-2">
            <label for="addDonorWebsite2" class="col-sm-2">Sitio web 2</label>
            <div class="col-sm-10">
              <input type="text" class="form-control modalInputText" id="addDonorWebsite2" name="donorWebsite2">
            </div>
          </div>
          <div class="row d-flex align-items-center m-2">
            <label for="addDonorCfdi" class="col-sm-2">CFDI</label>
            <div class="col-sm-10">
              <input type="file" class="form-control modalInputText" id="addDonorCfdi" name="donorCfdi" @change="handleFile($event)" accept=".pdf">
            </div>
          </div>
        </form>
        <div class="errores" id="errores"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-success" @click="addDonorAlert()">Agregar</button>
      </div>
    </div>
  </div>
</div>
</template>

<style>
.modalInputText {
  padding: 12px 20px !important;
  margin: 8px 0 !important;
  display: inline-block !important;
  border: 1px solid #ccc !important;
  border-radius: 4px !important;
  box-sizing: border-box !important;
}
.is-invalid {
  border-color: #dc3545 !important;
}
.errores {
  color:#dc3545;
}
</style>