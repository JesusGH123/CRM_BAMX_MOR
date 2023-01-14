//Controller

let mysql = require('mysql')
let config = require('../helpers/config') //Import
let connection = mysql.createConnection(config)
const multer = require('multer')

//Add file for a donor
module.exports.add_file = (request, response) => {
    // console.log(request.body)
    // console.log(request.file)
    var file_src = request.file.filename;
    let sql = "CALL SetCFDI(?, ?)"
    connection.query(sql, [request.params.id, file_src], (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        response.json(results)
    })
}

module.exports.get_file = (request, response) => {
    response.download('./uploads/' + request.params.file)
}