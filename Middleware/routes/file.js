//Routes

let express = require('express')
let router = express.Router()
const multer = require('multer')

let fileController = require('../controllers/fileController')

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, './uploads')
  },
  filename: (req, file, cb) => {
    cb(null, file.fieldname + '-' + Date.now() + '.pdf')
  }
})

const upload = multer({storage: storage})


router.post('/:id', upload.single('file'), fileController.add_file)
router.get('/:file', fileController.get_file)
router.get('/', fileController.export_csv)

module.exports = router