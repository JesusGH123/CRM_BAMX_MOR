//Routes

let express = require('express')
let router = express.Router()

let productsController = require('../controllers/productsController')

router.get('/', productsController.get_products)
router.get('/:id', productsController.get_donor_products)
router.post('/', productsController.add_product)
router.delete('/:product_id', productsController.delete_product)

module.exports = router