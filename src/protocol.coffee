os = require 'os'

module.exports = (subscribe, publish, edge, context) -> 

    subscribe 'event:register:viewport', (payload) -> 

        # console.log "REGISTER VIEWPORT ", edge.localId()
        context.gimbal ||= {}
        context.gimbal.viewports ||= {}
        context.gimbal.viewports[ edge.localId() ] = edge

        url = context.listen.server.url

        if url.match /\/\/0\.0\.0\.0/

            #
            # listening on 0.0.0.0, 
            # 
            # need to find a LAN accessable ip to 
            # connect the controller to
            #

            ifaces = os.networkInterfaces()

            for iface of ifaces
                for details in ifaces[iface]

                    continue if details.internal
                    continue unless details.family == 'IPv4'
                    continue if details.address.match /^192\.168\./

                    url = url.replace '0.0.0.0', details.address


        console.log "URL:", url
