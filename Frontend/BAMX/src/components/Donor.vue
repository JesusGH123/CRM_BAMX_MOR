<script>
import axios from 'axios'

export default {
  name: 'Donors',
  data() {
    return {
      donors: {}
    }
  },
  mounted() {
    this.getDonors()
  },
  methods: {
    getDonors() {
      try{
        axios.get('http://localhost:3000/')
        .then(response => {
          this.donors = response.data
        })
      } catch (error) {
        console.log(error)
      }
    }
    deleteDonor() {
      try {
        axios.delete('http://localhost:3000/donor/${donorId}'
        .then(response => {

        })
      } catch (error) {
        console.log(error)
      }
    }
    },
    deleteAlert(){
      this.$swal({
        title: '¿Estas seguro(a)?',
        text: "No podrás revertir esto!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Si, bórralo!'
      }).then((result) => {
        if (result.isConfirmed) {
          this.$swal(
            '¡Borrado!',
            'El registro ha sido borrado.',
            'success'
          )
          deleteDonor()
        }
      })
    }
  }
}
</script>

<template>
  <tr v-for="donor in donors" :key="donor.donor_id">
    <td>{{ donor.donor_id }}</td>
    <td>{{ donor.donor_name }}</td>
    <td>{{ donor.donor_city }}</td>
    <td>{{ donor.donor_colony }}</td>
    <td>{{ donor.donor_organization }}</td>
    <td>{{ donor.donor_type }}</td>
    <td>{{ donor.donor_website }}</td>
    <td>
      <router-link :to="{name: 'edit', params:{id: donor.donor_id}}">
        <button class="btn update" v-bind:id="donor.donor_id"><img src="../assets/pencil.png" title="editImage" width="16" height="16"/></button>
      </router-link>
    </td>
    <td>
      <button class="btn delete" v-bind:id="donor.donor_id" @click="deleteAlert()"><img src="../assets/trash.png" title="deleteImage" width="16" height="16"/></button>
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
</style>