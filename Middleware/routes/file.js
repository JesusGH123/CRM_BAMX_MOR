//Routes

let express = require('express')
let router = express.Router()
const multer = require('multer')

let fileController = require('../controllers/fileController')


// const upload = multer({ 
//   dest: './uploads',
//   filename: (req, file, cb) => {
//     cb(null, file.originalname + '-' + Date.now())
//   }
// })

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, './uploads')
  },
  filename: (req, file, cb) => {
    cb(null, file.fieldname + '-' + Date.now() + '.pdf')
  }
})

const upload = multer({storage: storage})


// router.get('/donor/:id', fileController.get_mails)
router.post('/:id', upload.single('file'), fileController.add_file)
router.get('/:file', fileController.get_file)
router.get('/download', fileController.export_csv)

module.exports = router