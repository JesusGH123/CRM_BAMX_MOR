<script>
import axios from 'axios'

export default{
  name: 'AddProduct',
  methods:{
    addProductAlert(){
      let nombre = document.getElementById('addProductName').value

      if(nombre === ''){
        this.$swal({
          title: 'Error',
          text: 'Porfavor, llena los campos obligatorios',
          icon: 'error',
          confirmButtonText: 'Ok'
        })
        return
      }
      
      this.$swal({
        title: 'Seguro que quieres agregar este producto?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Si'
      }).then((result) => {
        if (result.isConfirmed) {
          this.addProduct(nombre)
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
    addProduct(data){
      // console.log(data)
      try{
        axios.post('http://localhost:3000/product/', {}, {
          params: {
            name: data
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
<button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#addProduct">Agregar producto</button>

<!-- Modal -->
<div class="modal fade" id="addProduct" tabindex="-1" aria-labelledby="addProductLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addProductLabel">Agregar Producto</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="">
          <div class="row d-flex align-items-center m-2">
            <label class="col-form-label col-sm-2" for="addProductName">Nombre*</label>
            <div class="col-sm-10">
              <input type="text" class="form-control modalInputText" id="addProductName" name="productName">
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
        <button type="submit" class="btn btn-success" @click="addProductAlert()">Agregar</button>
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