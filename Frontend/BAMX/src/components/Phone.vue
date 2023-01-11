<script>
import axios from 'axios'
export default{
  name: 'Phone',
  props: {
    idDonor: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      phones: {}
    }
  },
  mounted() {
    this.getPhones()
  },
  methods: {
    validate: function(event){
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
    getPhones() {
      try{
        axios.get('http://localhost:3000/phone/' + this.idDonor)
        .then(response => {
          this.phones = response.data
          // console.log(this.phones)
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
    addAlert(){
      var phone = document.getElementById('addPhoneNumber').value

      if(phone.length < 10){
        this.$swal({
          title: "¡Error!",
          text: "El numero debe tener 10 digitos.",
          icon: "error"
        })
        return
      }

      this.$swal({
        title: 'Agregar numero',
        text: '¿Desea agregar el numero ' + phone + ' a este donador?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Si"
      }).then((result) => {
        if (result.isConfirmed) {
          this.addPhone()
          this.$swal({
            title: "¡Agregado!",
            text: "El registro ha sido agregado.",
            icon: "success"
          }).then((result) => {
            if (result.isConfirmed) {
              location.reload()
            }
          })
        }else
          this.$swal("¡Cancelado!", "El registro no ha sido agregado.", "error");
      })
    },
    addPhone(){
      event.preventDefault() // prevent form submit
      try {
            axios.post('http://localhost:3000/phone/' + this.idDonor, {}, {
              params: {
                phone: document.getElementById('addPhoneNumber').value
              }
            })
            .then(response => {
              console.log(response)
            })
          } catch (error) {
            console.log(error)
          }
    }
  }
}
</script>

<template>
  <form class="limited-form">
    <div v-for= "(phone, index) in phones" :key="phone.phone_id">
      <label for="phone" class="form-label">Tel&eacute;fono {{index + 1}}</label>
      <div class="input-group">
        <input class="form-control mb-3" type="text" @keypress="validate($event)" maxlength="10" name="phone" id="phone" :value="phone.donor_phone">
        <button class="btn btn-outline-secondary delete-form" type="button" name="id" :id="phone.phone_id" @click="deleteAlert(phone.phone_id)"><img src="../assets/trash.png" title="deleteImage" width="16" height="16"/></button>
      </div>
    </div>
  </form>
  <div class="d-flex align-content-center align-items-center btn-div">
    <button type="button" class="btn btn-outline-success btn-add" data-bs-toggle="modal" data-bs-target="#addPhone">
      <p class="text-btn">+</p>
    </button>
  </div>


<!-- Modal -->
<div class="modal fade" id="addPhone" tabindex="-1" aria-labelledby="addPhoneLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addPhoneLabel">Agregar tel&eacute;fono</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="">
          <div class="mb-3">
            <label for="phone" class="form-label">Tel&eacute;fono</label>
            <input type="text" @keypress="validate($event)" maxlength="10" class="form-control" id="addPhoneNumber" name="phone" placeholder="Tel&eacute;fono">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" @click="addAlert()">Save changes</button>
      </div>
    </div>
  </div>
</div>

</template>

<style>
.limited-form{
  min-height: 340px;
  max-height: 340px;
  overflow-y: scroll;
  padding: 0 20px;
}
.delete-form{
  padding: 2px 10px !important;
  min-height: 42.1px;
  max-height: 42.1px;
}
button:hover.delete-form{
  background-color:rgba(239, 12, 12, 0.25) !important;
}
.btn-add{
  border-radius: 50% !important;
  min-width: 50px !important;
  min-height: 50px !important;
  max-width: 50px !important;
  max-height: 50px !important;
  margin: 0 auto !important;
  padding: 0 !important;
}
.text-btn{
  font-size: 30px;
  font-weight: 600;
  margin: 0;
  min-width: 50px;
  max-width: 50px;
  min-height: 50px;
  max-height: 50px;
}
</style>