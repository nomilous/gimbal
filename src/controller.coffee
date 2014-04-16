
module.exports = controller = (opts, callback) -> 

    callback null, 

        headers: 'Content-Type': 'text/javascript'
        body: "(#{
            module.exports.client.toString()
        }).call(self);"

controller.$www = {}

module.exports.client = -> 

    dom   = require 'component~dom@1.0.5'
    three = require 'cvdlab~three@0.60.0'


