express = require 'express'
plex    = require 'plex'
gimbal  = require './gimbal'
app     = express()

module.exports = (port = 3000) -> 

    app.get '/', (req, res) -> res.send ''
    app.use gimbal

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
            server: app.listen port

    return context.listen.server
