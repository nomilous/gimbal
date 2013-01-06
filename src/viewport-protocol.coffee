os     = require 'os'
qrCode = require 'qrcode-npm'

module.exports = (subscribe, publish, edge, context) -> 

    imageTag = undefined

    subscribe 'event:register:viewport', (payload) -> 

        # console.log "REGISTER VIEWPORT ", edge.localId()
        context.gimbal ||= {}
        context.gimbal.viewports ||= {}
        context.gimbal.viewports[ edge.localId() ] = edge

        unless imageTag
        
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

                        #
                        # TODO: it needs to be the wifi interface
                        #

                if url.match /\/\/0\.0\.0\.0/

                    throw 'could not find wifi LAN ip'

            #
            # generate a QR code imageTag with connectSpec for 
            # this viewport
            #

            connectSpec = "#{ url } #{ edge.localId() }"
            qr = qrCode.qrcode 3, 'L'
            qr.addData connectSpec
            qr.make()
            imageTag = qr.createImgTag 6

        #
        # send the imageTag to the viewport
        #

        publish 'event:register:viewport:ok', imageTag

