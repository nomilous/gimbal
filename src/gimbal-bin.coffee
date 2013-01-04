app    = require('express')() 
gimbal = require './gimbal'

module.exports = (port = 3000) -> 

    app.get '/', (req, res) -> res.send ''
    app.use gimbal
    app.listen port
