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
            # downlinks:
            # 
            # - to local game viewports (browser)
            # - to game control 'pad' (android/ios app)
            # 

            adaptor: 'socket.io'
            server: et.al
                port: port

            onConnect: (edge) -> 

                #
                # client connected, initiate protocol
                #

                edge.getPublisher() 'event:client:start'


        protocol: require './protocol'


    #
    # TEMPORARY (pending https://github.com/nomilous/cetera)
    # 
    # hack the viewport clientside up
    #

    context.listen.server.use require('connect-jade')

        root: __dirname + '/../views'


    context.listen.server.get '/', (req, res) -> 

        res.render 'index'


    return context
