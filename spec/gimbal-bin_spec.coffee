should  = require 'should'
request = require 'request'

describe "gimbal-bin", ->

    server = undefined
    port   = 3333
    uri    = "http://localhost:#{  port  }"


    before (done) ->
        server = require('../src/gimbal-bin')()
        done()

    after -> 
        server.close()


    it "starts the game server", (done) ->

        request uri, (error, response, body) ->
            response.statusCode.should.equal 200
            done()
