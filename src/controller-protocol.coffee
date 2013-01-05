module.exports = (subscribe, publish, edge, context) -> 

    subscribe 'event:register:controller', (payload) -> 

        console.log "REGISTER CONTROLLER ", edge.localId()

        publish 'event:register:controller:ok', ''


