should  = require 'should'
request = require 'request'

describe "gimbal-bin", ->

    server = undefined
    port   = 22222
    uri    = "http://localhost:#{  port  }"


    before (done) ->
        server = require('../src/gimbal-bin')(port)
        done()

    after -> 
        server.close()

    it 'starts the server', (done) ->

        request uri, (error, response, body) ->
            response.statusCode.should.equal 200
            done()


    it 'has a listening websocket', (passTest) -> 

        require('socket.io-client')

            .connect("http://localhost:#{  port  }")

                .on 'connect', -> 

                    passTest() 

                        # because it did connect
