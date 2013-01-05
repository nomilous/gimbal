should   = require 'should'
request  = require 'request'

describe "gimbal-bin", ->

    context = undefined
    port    = 22222

    before (done) ->
        context = require('../src/gimbal-bin')(port)
        done()

    after -> 
        context.listen.server.close()

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
