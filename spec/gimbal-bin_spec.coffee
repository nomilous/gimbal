should   = require 'should'
request  = require 'request'

describe "gimbal-bin", ->

    server = undefined
    port   = 22222

    before (done) ->
        server = require('../src/gimbal-bin')(port)
        done()

    after -> 
        server.close()

    it 'has a listening http server', (done) ->

        request "http://localhost:#{ port }", 

            (error, response, body) ->

                response.statusCode.should.equal 200
                done()


    it 'sends event:client:start when websocket client connects', (passTest) -> 

        require('socket.io-client')

            .connect("http://localhost:#{ port }")

                .on 'event:client:start', (payload) -> 

                    @disconnect()
                    passTest()
