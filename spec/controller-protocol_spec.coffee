should     = require 'should'
MockClient = require '../src/mock-client'

describe 'controller-protocol', -> 

    context    = undefined
    port       = 22222
    controller = undefined
    clientid   = undefined

    viewportReceived = {}

    before (done) ->

        context = require('../src/gimbal-bin')(port)

        # 
        # mock registered primary viewport with publisher 
        #

        context.gimbal = 
            viewports: 
                PRIMARY_VIEWPORT_ID:
                    getPublisher: -> 
                        return (event, payload) -> 
                            viewportReceived[event] = payload

        controller = new MockClient port, 'controller', 500, -> 

            #
            # gives client 500 mills to connect and stuff
            #

            clientid = controller.connection.socket.sessionid
            done()

    after -> 

        controller.connection.disconnect()
        context.listen.server.close()


    it 'has reference to the registered controller edge', (done) -> 

        context.gimbal.controllers[clientid].edge.should.be.an.instanceof Object
        done()

    it 'has reference to the first registered viewport as the primary', (done) -> 

        context.gimbal.controllers[clientid].primary.should.equal 'PRIMARY_VIEWPORT_ID'
        done()

    it 'has reference to pending associated viewports', (done) -> 

        context.gimbal.controllers[clientid].viewports.should.be.an.instanceof Array
        done()

    
    it 'broadcasts inbound controller events to all associated (bound) viewport(s)', (done) ->

        #
        # generate a fake controller event across the socket
        #

        controller.send 'event:controller', {

            event: 'event:code'
            payload: 'DATA'

        }, 500, ->

            #
            # and wait a spot...
            # before testing that it would have been sent to the viewport
            #

            viewportReceived['event:code'].should.equal 'DATA'
            done()

