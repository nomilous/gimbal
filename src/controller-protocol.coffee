module.exports = (subscribe, publish, edge, context) -> 

    id = edge.localId()
    viewports         = undefined
    primaryViewportID = undefined

    subscribe 'event:register:controller', (payload) -> 

        #
        # create viewport association structure
        # 
        # TODO: cull old controller refs
        #

        console.log "RECEIVED:", payload

        context.gimbal ||= {}
        context.gimbal.controllers ||= {}

        primaryViewportID = payload.viewport.id
        inputCube         = payload.input_cube

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
        # notify the viewport of it's new controller
        #

        send = context.gimbal.viewports[ primaryViewportID ].getPublisher()
        send 'event:assigned', 
            controller: id
            primary: true
            input_cube: inputCube


        #
        # send ack to controller
        #

        publish 'event:register:controller:ok', 
            viewport: 
                id: primaryViewportID
                primary: true
            config:
                pending: "pending"

    
    subscribe 'event:release:controller', (payload) -> 

        #
        # Controller release resets all associated viewports
        #

        console.log 'RECEIVED: event:release:controller'

        viewportArray = [] # viewports that were released (for ack to controller)

        if viewports

            for viewportID in viewports

                #
                # inform the viewport it was released
                #

                send = context.gimbal.viewports[viewportID].getPublisher()
                send 'event:reset', ''

                viewportArray.push
                    id: viewportID
                    primary: (viewportID == primaryViewportID)


            viewports = undefined


        context.gimbal.controllers[ id ].disconnected = true    

        #
        # send ack
        #

        publish 'event:release:controller:ok',
            viewports: viewportArray



    subscribe 'event:viewport:broadcast', (payload) -> 

        #
        # Controller events are broadcast to all associated viewports
        #

        #console.log 'RECEIVED: event:viewport:broadcast %s', JSON.stringify payload

        return unless viewports

        for viewportID in viewports

            send = context.gimbal.viewports[viewportID].getPublisher()

            send payload.code, payload.event

