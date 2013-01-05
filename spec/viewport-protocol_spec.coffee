should     = require 'should'
MockClient = require '../src/mock-client'


describe 'protocol', -> 

    context  = undefined
    port     = 22222
    viewport = undefined


    before (done) ->
        context = require('../src/gimbal-bin')(port)
        viewport = new MockClient port, 'viewport', 500, -> done()

    after -> 
        viewport.connection.disconnect()
        context.listen.server.close()

    it 'has a viewports array in context', (done) -> 

        clientid = viewport.connection.socket.sessionid
        context.gimbal.viewports[ clientid ].should.be.an.instanceof Object
        done()


    it 'enables viewport bind to controller via QR codes', (done) ->

        viewport.received['event:register:viewport:ok'].should.match /image\/gif;base64/
        done()

