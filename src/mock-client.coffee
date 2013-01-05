ioClient = require 'socket.io-client'

module.exports = class MockClient

    constructor: (port, mode, wait, toCallback) -> 

        #
        # <mode> 
        #   viewport   - behaves like the browser viewport
        #   controller - behaves like the android/ios app
        # 

        #
        # this was called in a berfore hook in the spec
        # timeout allows a moment for the protocol to be enacted
        #

        setTimeout (-> toCallback()), wait


        #
        # received events are stored in this
        #

        @received ||= {}


        @connection = ioClient.connect "http://localhost:#{ port }"


        #
        # mock responce to 'event:client:start'
        #

        @connection.on 'event:client:start', (payload) => 

            switch mode

                when 'viewport' 

                    @connection.emit "event:register:viewport"

                when 'controller'

                    @connection.emit "event:register:controller", 'PRIMARY_VIEWPORT_ID'


        # 
        # viewport protocol
        # 


        @connection.on 'event:register:viewport:ok', (payload) => 
       
            @received['event:register:viewport:ok'] = payload





        #
        # controller protocol
        #

        @connection.on 'event:register:controller:ok', (payload) => 

            @received['event:register:controller:ok'] = payload

