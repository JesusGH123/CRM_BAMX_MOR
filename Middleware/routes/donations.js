//Routes

let express = require('express')
let router = express.Router()

let donationsController = require('../controllers/donationsController')

router.get('/:id', donationsController.get_donation)
router.post('/:id', donationsController.add_donation)
router.delete('/:donation_id', donationsController.delete_donation)

module.exports = router