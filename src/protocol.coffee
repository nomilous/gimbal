module.exports = (subscribe, publish) -> 

    subscribe 'event:register:viewport', (payload) -> 

        console.log "received:", 'event:register:viewport', payload

        console.log 'registering viewport'

        #
        # TODO: store reference to new viewport 
        #


    subscribe 'event:register:controller', (payload) -> 

        console.log "received:", 'event:register:controller', payload

        console.log 'registering controller'

        #
        # TODO: store reference to new controller
        #



#
# TODO: go make some toast... (maybe watch a movie)
#
