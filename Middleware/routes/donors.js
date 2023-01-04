//Routes

let express = require('express')
let router = express.Router()

let donorsController = require('../controllers/donorsController')

router.get('/', donorsController.get_donors)
router.get('/donor/:id', donorsController.get_donor)
router.post('/donor', donorsController.add_donor)
router.delete('/donor/:id', donorsController.delete_donor)
router.put('/donor/:id', donorsController.update_donor)

module.exports = router