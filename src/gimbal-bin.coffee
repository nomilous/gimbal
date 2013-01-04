plex    = require 'plex'
et      = require 'et'
gimbal  = require './gimbal'

module.exports = (port = 3000) -> 

    context = plex.start

        mode: 'proxy'
        connect:

            #
            # uplink to storage/interact
            #

            adaptor: 'socket.io'
            uri: 'http://localhost:3332' # pending live site 

        listen:

            #
            # downlink to local game instance(s)
            # 

            adaptor: 'socket.io'
            server: et.al
                port: port

    context.listen.server.get '/', (req, res) -> res.send ''

    return context.listen.server
