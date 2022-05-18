//import auth
// const auth = require("../auth")
// const jwt = require("jsonwebtoken")
// const SECRET_KEY = "BelajarNodeJSItuMenyengankan"

//import library
//import express
const express = require("express")
const app = express()
app.use(express.json())

//import model
const model = require('../models/index');
const paket = model.paket
const outlet = model.outlet

// import multer
// const multer = require("multer")
// const path = require("path")
// const fs = require("fs")

// //config storage image
// const storage = multer.diskStorage({
//     destination: (req, file, cb) => {
//         cb(null, "./image/paket")
//     },
//     filename: (req, file, cb) => {
//         cb(null, "img-" + Date.now() + path.extname(file.originalname))
//     }
// })
// let upload = multer({ storage: storage })

//endpoint menampilkan semua data paket, method: GET, function: findAll()
// app.get("/",  async (req, res) => {
//     let result =  await paket.findAll({
//         include: [
//             "outlet",
//             {
//                 model: model.outlet,
//                 as : "outlet",
//             }
//         ]
//     })
//     res.json({
//         paket: result
//     })
// })
app.get("/", async (req, res) => {
    paket
        .findAll({
            include: [
                "outlet",
                {
                    model: model.outlet,
                    as : "outlet",
                }
            ]
        })
        .then(result => {
            res.json({paket: result})
        })
        .catch(error => {
            res.json({message: error.message})
        })
    })

app.get("/:id_paket", async (req, res) => {
    let result =  await paket.findOne({
        where: {id_paket: req.params.id_paket},
        include: [
            "outlet",
            {
                model: model.outlet,
                as : "outlet",
            }
        ]
    })
    res.json({
        paket: result
    })
})

app.get("/getByOut/:id_outlet", async (req, res) => {
    let result =  await paket.findAll({
        where: {id_outlet: req.params.id_outlet},
        include: [
            "outlet",
            {
                model: model.outlet,
                as : "outlet",
            }
        ]
    })
    res.json({
        paket: result
    })
})

//endpoint untuk menyimpan data paket, METHOD: POST, function: create
app.post("/", (req, res) => {
    let data = {
        id_outlet: req.body.id_outlet,
        jenis: req.body.jenis,
        nama_paket: req.body.nama_paket,
        harga: req.body.harga,
        // image: req.file.filename
    }

    paket.create(data)
        .then(result => {
            res.json({
                message: "data has been inserted"
            })
        })
        .catch(error => {
            res.json({
                message: error.message
            })
        })
})

//endpoint mengupdate data paket, METHOD: PUT, function:update
app.put("/:id", (req, res) => {
    let param = {
        id_paket: req.params.id
    }
    let data = {
        id_outlet: req.body.id_outlet,
        jenis: req.body.jenis,
        nama_paket: req.body.nama_paket,
        harga: req.body.harga
    }
    paket.update(data, { where: param })
        .then(result => {
            res.json({
                message: "data has been updated"
            })
        })
        .catch(error => {
            res.json({
                message: error.message
            })
        })
})

//endpoint menghapus data paket, METHOD: DELETE, function: destroy
app.delete("/:id", async (req, res) => {
    // let param = {
    //     id_paket: req.params.id
    // }
    // paket.destroy({ where: param })
    //     .then(result => {
    //         res.json({
    //             message: "data has been deleted"
    //         })
    //     })
    //     .catch(error => {
    //         res.json({
    //             message: error.message
    //         })
    //     })
    try {
        let param = { id_paket: req.params.id}

        // delete data
        paket.destroy({where: param})
        .then(result => {
           
            res.json({
                message: "data has been deleted",
            })
        })
        .catch(error => {
            res.json({
                message: error.message
            })
        })

    } catch (error) {
        res.json({
            message: error.message
        })
    }
})


module.exports = app