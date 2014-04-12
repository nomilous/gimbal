module.exports = root = (opts, callback) -> 

    callback null, 

        statusCode: 301 # redirect
        headers: location: '/home'

root.$www = {}

root.home = require './home'
