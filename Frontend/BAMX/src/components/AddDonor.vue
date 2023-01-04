<script>
import axios from 'axios'

export default{
  name: 'AddDonor',
  methods:{
    addDonor(data){
      try{
        axios.post('http://localhost:3000/donor', data)
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
<button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#addDonor">Agregar donador</button>

<!-- Modal -->
<div class="modal fade" id="addDonor" tabindex="-1" aria-labelledby="addDonorLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addDonorLabel">Agregar tel&eacute;fono</h5>
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
        <button type="button" class="btn btn-primary" >Save changes</button>
      </div>
    </div>
  </div>
</div>
</template>

<style>
</style>