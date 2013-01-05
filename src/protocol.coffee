module.exports = (subscribe, publish, edge, context) -> 

    subscribe 'event:register:viewport', (payload) -> 

        console.log "REGISTER VIEWPORT ", edge.localId()
        context.gimbal ||= {}
        context.gimbal.viewports ||= {}
        context.gimbal.viewports[ edge.localId() ] = edge
