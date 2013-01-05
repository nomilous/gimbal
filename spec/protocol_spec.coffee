should     = require 'should'
MockClient = require '../src/mock-client'


describe 'protocol', -> 

    server = undefined
    port   = 22222

    before (done) ->
        server = require('../src/gimbal-bin')(port)
        done()

    after -> 
        server.close()

    it """enables distinguishing between an attaching browser viewport
          and an andrid/ios controller""", (done) -> 

        viewportClient   = new MockClient port, 'viewport'
        controllerClient = new MockClient port, 'controller', 'event:register:controller', -> done()


    it 'enables viewport bind to controller via QR codes'

    it 'enables broadcasting inbound controller events to the associated (bound) viewport(s)'
