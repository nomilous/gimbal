ioClient = require 'socket.io-client'

module.exports = class MockClient

    constructor: (port, mode, wait, toCallback) -> 

        #
        # <mode> 
        #   viewport   - behaves like the browser viewport
        #   controller - behaves like the android/ios app
        # 

        @connection = ioClient.connect "http://localhost:#{ port }"

        @connection.on 'event:client:start', (payload) => 

            @connection.emit "event:register:#{ mode }", pending: 'DATA'

        setTimeout (-> toCallback()), wait

