{readFileSync} = require 'fs'

root = (opts, callback) -> 

    callback null, 

        statusCode: 301 # redirect
        headers: location: '/viewport'


root.build = (opts, callback) -> 

    callback null,

        headers: 'Content-Type': 'text/javascript'
        body: readFileSync "#{__dirname}/../build/build.js"


root.$www        = {}
root.build.$www  = {}



root.viewport    = require './viewport'
root.controller  = require './controller'

module.exports = root