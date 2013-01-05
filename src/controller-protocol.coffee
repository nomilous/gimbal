module.exports = (subscribe, publish, edge, context) -> 

    subscribe 'event:register:controller', (primaryViewportID) -> 

        #
        # create viewport association structure
        # 
        # TODO: cull old controller refs
        #

        context.gimbal ||= {}
        context.gimbal.controllers ||= {}

        id = edge.localId()

        context.gimbal.controllers[ id ] = 

            #
            # the controller is attached at this edge (plex)
            #

            edge: edge

            #
            # the first registered viewport
            #

            primary: primaryViewportID

            #
            # controller supports multiple viewports...
            # 
            # [ here's why ](https://github.com/mrdoob/three.js/blob/master/src/cameras/PerspectiveCamera.js#L37)
            #

            viewports: []


        context.gimbal.controllers[ id ].viewports.push primaryViewportID

        #
        # send ack
        #

        publish 'event:register:controller:ok'


    subscribe 'event:controller', (payload) -> 

        #
        # Controller events are broadcast to all associated viewports
        #

        console.log 'RECEIVED: event:controller %s', JSON.stringify payload

        id = edge.localId()

        registeredViewports = context.gimbal.controllers[id].viewports

        for viewportID in registeredViewports

            send = context.gimbal.viewports[viewportID].getPublisher()
            send payload.event, payload.payload

