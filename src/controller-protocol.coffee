module.exports = (subscribe, publish, edge, context) -> 

    id = edge.localId()
    viewports = undefined

    subscribe 'event:register:controller', (primaryViewportID) -> 

        #
        # create viewport association structure
        # 
        # TODO: cull old controller refs
        #

        context.gimbal ||= {}
        context.gimbal.controllers ||= {}

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
        # pupulate reference to registered viewports
        #

        viewports = context.gimbal.controllers[ id ].viewports


        #
        # send ack
        #

        publish 'event:register:controller:ok', primaryViewportID

    
    subscribe 'event:release:controller', (payload) -> 

        #
        # Controller release resets all associated viewports
        #

        console.log 'RECEIVED: event:release:controller'

        if viewports

            for viewportID in viewports

                send = context.gimbal.viewports[viewportID].getPublisher()
                send 'event:reset', ''

            viewports = undefined

            context.gimbal.controllers[ id ].disconnected = true

        #
        # send ack
        #

        publish 'event:release:controller:ok'


    subscribe 'event:controller', (payload) -> 

        #
        # Controller events are broadcast to all associated viewports
        #

        console.log 'RECEIVED: event:controller %s', JSON.stringify payload

        return unless viewports

        for viewportID in viewports

            send = context.gimbal.viewports[viewportID].getPublisher()

            #
            # inbound controller payload may have multiple events
            #

            for event of payload

                send event, payload[event]

