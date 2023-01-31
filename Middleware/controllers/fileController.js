//Controller

let mysql = require('mysql')
let config = require('../helpers/config') //Import
let connection = mysql.createConnection(config)
const multer = require('multer')

//Add file for a donor
module.exports.add_file = (request, response) => {
    var file_src = request.file.filename;
    let sql = "CALL SetCFDI(?, ?)"
    connection.query(sql, [request.params.id, file_src], (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        response.json(results)
    })
}

//Export Donor info as CSV
module.exports.export_csv = (request, response) => {
    let sql = "CALL ExportCSV()"
    connection.query(sql, null, (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        let name = results[0][0].NAME
        // TODO: CHANGE PATH IN PRODUCTION
        response.download('/home/ubuntu/temp/csv-docs/' + name)
    })
}

module.exports.get_file = (request, response) => {
    response.download('/home/ubuntu/temp/cfdi-docs/' + request.params.file)
}