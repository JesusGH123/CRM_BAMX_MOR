<script>
import axios from 'axios'
import Town from './Town.vue'
import TypeDonor from './TypesDonor.vue'
import CategoryDonor from './CategoryDonor.vue'

export default{
  name: 'AddDonor',
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
      // VALIDATE IF THE FIELDS ARE EMPTY
      let nombre = document.getElementById('addDonorName').value
      let municipio = document.getElementById('municipio').value
      let colonia = document.getElementById('colonia').value
      let organizacion = document.getElementById('addDonorOrganization').value
      
      let tipos = document.getElementsByClassName('type-check')
      var tipo = []
      for (let i = 0; i < tipos.length; i++) {
        if(tipos[i].checked){
          tipo.push(tipos[i].value)
        }
      }

      if(nombre === '' || municipio === '' || colonia === '' || organizacion === '' || tipo.length === 0){
        this.$swal({
          title: 'Error',
          text: 'Porfavor, llena los campos obligatorios',
          icon: 'error',
          confirmButtonText: 'Ok'
        })
        return
      }
      
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
          this.addDonor()
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
        }
      })
    },
    addDonor(){
      try{
        axios.post('http://localhost:3000/donor',{}, {
          params: {
            name: document.getElementById('addDonorName').value,
            city: document.getElementById('municipio').value,
            colony: document.getElementById('colonia').value,
            organization: document.getElementById('addDonorOrganization').value,
            website1: document.getElementById('addDonorWebsite1').value,
            website2: document.getElementById('addDonorWebsite2').value,
            cfdi: null
          }
        })
        .then(response => {
          console.log(response)
        })
      } catch (error) {
        console.log(error)
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
              <Town />
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
        </form>
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
</style>