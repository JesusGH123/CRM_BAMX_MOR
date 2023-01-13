<script>
import axios from 'axios'
export default{
  name: 'Donation',
  props: {
    idDonor: {
      type: Number,
      required: true
    }
  },
  data() {
    return {
      donations: {},
      products: {}
    }
  },
  mounted() {
    this.getDonations()
    this.getProducts()
  },
  methods: {
    getProducts(){
      try{
        axios.get('http://localhost:3000/product')
        .then(response => {
          this.products = response.data
          // console.log(this.products)
        })
      } catch (error) {
        console.log(error)
      }
    },
    deleteDonation(idDonation){
      console.log(idDonation)
      // TODO: Delete donation
      try {
        axios.delete('http://localhost:3000/donation/' + idDonation)
        .then(response => {
          console.log(response)
        })
      } catch (error) {
        console.log(error)
      }
    },
    getDonations() {
      // TODO: Get donations
      try{
        axios.get('http://localhost:3000/donation/' + this.idDonor)
        .then(response => {
          this.donations = response.data
          console.log(this.donations)
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
                  this.deleteDonation(id)
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
      let productID = document.getElementById('addProduct').value
      let product = this.products.find(product => product.product_id == productID)
      product = product.product_name

      this.$swal({
        title: 'Agregar producto/donacion',
        text: '¿Desea agregar el producto ' + product + ' a este donador?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Si"
      }).then((result) => {
        if (result.isConfirmed) {
          this.addDonation(productID)
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
    addDonation(id){
      event.preventDefault() // prevent form submit
      try {
            axios.post('http://localhost:3000/donation/' + this.idDonor, {}, {
              params: {
                product_id: id,
                donation_date: null,
                donation_observation: null,
                product_quantity: null,
                product_unit: null
              }
            })
            .then(response => {
              console.log(response)
            })
          } catch (error) {
            console.log(error)
          }
    },
    capitalize(data){
        return data.charAt(0).toUpperCase() + data.slice(1)
    }
  }
}
</script>

<template>
  <form class="limited-form">
    <div v-for= "donation in donations" :key="donation.donation_id">
      <span v-for="product in products" :key="product.product_id">
        <div v-if="product.product_id === donation.product_id" class="input-group">
          <input disabled class="form-control mb-3" type="text" name="donation" :id="'donInp' + donation.donation_id" :value="capitalize(product.product_name)">
          <button class="btn btn-outline-secondary delete-form" type="button" name="id" :id="'don' + donation.donation_id" @click="deleteAlert(donation.donation_id)"><img src="../assets/trash.png" title="deleteImage" width="16" height="16"/></button>
        </div>
      </span>
    </div>
  </form>
  <div class="d-flex align-content-center align-items-center btn-div">
    <button type="button" class="btn btn-outline-success btn-add" data-bs-toggle="modal" data-bs-target="#addDonation">
      <p class="text-btn">+</p>
    </button>
  </div>


<!-- Modal -->
<div class="modal fade" id="addDonation" tabindex="-1" aria-labelledby="addDonationLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addDonationLabel">Agregar donaci&oacute;n/producto</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="">
          <div class="mb-3">
            <label for="phone" class="form-label">Producto</label>
            <!-- Dropdown of the products -->
            <select class="form-select" aria-label="Default select example" id="addProduct">
              <option selected>Selecciona un producto</option>
              <template v-for="product in products">
                <template v-if="this.donations.length > 0" v-for="donation in donations">
                  <option v-if="product.product_id !== donation.product_id" :value="product.product_id">{{capitalize(product.product_name)}}</option>
                </template>
                <template v-else>
                  <option :value="product.product_id">{{capitalize(product.product_name)}}</option>
                </template>
              </template>
            </select>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-success" @click="addAlert()">Save changes</button>
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