<script>
import axios from 'axios'
import Town from './Town.vue'

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
  },
  components:{
    Town
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
          <div class="row mb-4">
            <div class="col">
              <input type="text" class="form-control modalInputText" id="addDonorName" name="donorName" placeholder="Nombre">
            </div>
            <div class="col">
              <input type="text" class="form-control modalInputText" id="addDonorOrganization" name="donorOrganization" placeholder="Organización">
            </div>
          </div>
          <div class="row">
            <div class="col">
              <input type="text" class="form-control modalInputText" id="addDonorWebsite1" name="donorWebsite1" placeholder="Sitio web 1">
            </div>
            <div class="col">
              <input type="text" class="form-control modalInputText" id="addDonorWebsite2" name="donorWebsite2" placeholder="Sitio web 2">
            </div>
          </div>
          <div class="row">
            <div class="col">
              <!-- <input type="text" class="form-control modalInputText" id="addDonorMunicipality" name="donorMunicipality" placeholder="Municipio"> -->
              <Town />
            </div>
            <!-- <div class="col">
              <input type="text" class="form-control modalInputText" id="addDonorColony" name="donorColony" placeholder="Colonia">
            </div> -->
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
.modalInputText {
  padding: 12px 20px !important;
  margin: 8px 0 !important;
  display: inline-block !important;
  border: 1px solid #ccc !important;
  border-radius: 4px !important;
  box-sizing: border-box !important;
}
</style>