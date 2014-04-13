module.exports = root = (opts, callback) -> 

    callback null, 

        statusCode: 301 # redirect
        headers: location: '/viewport'

root.$www = {}

root.viewport = require './viewport'
