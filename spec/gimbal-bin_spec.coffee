should  = require 'should'
request = require 'request'

describe "gimbal-bin", ->

    server = undefined
    port   = 3333
    uri    = "http://localhost:#{  port  }"


    before (done) ->
        server = require('../src/gimbal-bin')(port)
        done()

    after -> 
        server.close()

    it "starts the server", (done) ->

        request uri, (error, response, body) ->
            response.statusCode.should.equal 200
            done()

    it 'returns the server', (done) -> 

        server.connections.should.equal 1  # previous test connected client 
        done()                             # (surprised it's still connected tho...) 
