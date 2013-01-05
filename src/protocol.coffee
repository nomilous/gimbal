module.exports = (subscribe, publish, edge, context) -> 

    subscribe 'event:register:viewport', (payload) -> 

        console.log "REGISTER VIEWPORT ", edge.localId()
        context.viewports ||= {}
        context.viewports[ edge.localId() ] = edge
