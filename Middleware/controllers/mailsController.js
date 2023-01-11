//Controller

let mysql = require('mysql')
let config = require('../helpers/config') //Import
let connection = mysql.createConnection(config)


//Get all donor mails


//Get all mails for a specific donor
module.exports.get_mails = (request, response) => {
    let sql = "SELECT donor_mail FROM DonorMail WHERE donor_id = ?"
    connection.query(sql, [request.params.id], (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        response.json(results)
    })
}

//Add mail for a donor
module.exports.add_mail = (request, response) => {
    let sql = "CALL AddMailToDonor(?, ?)"
    connection.query(sql, [request.params.id, request.query.phone], (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        response.json(results)
    })
}
