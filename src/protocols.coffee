module.exports = (subscribe, publish, edge, context) -> 

    subscribe 'request:socket:disconnect', (payload) -> 

        console.log 'RECEIVED: request:socket:disconnect from: ', edge.localId()
        edge.connection.disconnect()

    require('../lib/viewport-protocol')(subscribe, publish, edge, context)
    require('../lib/controller-protocol')(subscribe, publish, edge, context)
