{readFileSync} = require 'fs'

root = (opts, callback) -> 

    callback null, 

        statusCode: 301 # redirect
        headers: location: '/viewport'


root.bundle = (opts, callback) -> 

    callback null,

        headers: 'Content-Type': 'text/javascript'
        body: readFileSync "#{__dirname}/../bundle.js"


root.$www        = {}
root.bundle.$www  = {}



root.viewport    = require './viewport'
root.controller  = require './controller'

module.exports = root