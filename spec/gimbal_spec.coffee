should  = require 'should'
request = require 'request'

describe 'gimbal', -> 

    server     = undefined
    port       = 3333
    baseUri    = "http://localhost:#{  port  }"

    before (done) ->
        app = require('express')()
        app.use require '../src/gimbal'
        server = app.listen port
        done()

    after -> 
        server.close()

    describe 'middleware', -> 

        it 'responds to /gimbal.js', (done) -> 

            request baseUri + '/gimbal.js', (error, response, body) ->
                response.statusCode.should.equal 200
                done()
