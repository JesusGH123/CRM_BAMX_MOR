//Controller

let mysql = require('mysql')
let config = require('../helpers/config') //Import
let connection = mysql.createConnection(config)

//Get all products for a specific donor
module.exports.get_products = (request, response) => {
    let sql = "SELECT * FROM Product"
    connection.query(sql, (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        response.json(results)
    })
}

//Get all products for a specific donor
module.exports.get_donor_products = (request, response) => {
    let sql = "SELECT * FROM DonorProduct WHERE donor_id = ?"
    connection.query(sql, [request.params.id], (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        response.json(results)
    })
}

//Add products for a donor
module.exports.add_product = (request, response) => {
    let sql = "CALL AddProductForDonation(?)"
    connection.query(sql, [request.query.name], (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        response.json(results)
    })
}


//Delete specific product
module.exports.delete_product = (request, response) => {
    let sql = "DELETE FROM Product WHERE product_id = ?"
    connection.query(sql, [request.params.product_id], (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        response.json(results)
    })
}

// Filter products
module.exports.filter_products = (request, response) => {
  let sql = "CALL FilterProducts(?)";
    connection.query(sql, request.query.name, (error, results, fields) => {
        if(error) {
            response.send(error)
        }
        response.json(results)
    })
}
