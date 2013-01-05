ioClient = require 'socket.io-client'

module.exports = class MockClient

    constructor: (port, mode, @watchResponseEvent, @toCallback) -> 

        #
        # <mode> 
        #   viewport   - behaves like the browser viewport
        #   controller - behaves like the android/ios app
        # 

        @socket = ioClient.connect "http://localhost:#{ port }"

        @socket.on 'event:client:start', (payload) => 

            @respond "event:register:#{ mode }", pending: 'DATA'

            
    respond: (event, payload) -> 

        @socket.emit event, payload

        if event == @watchResponseEvent

            @toCallback()
