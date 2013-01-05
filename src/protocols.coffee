module.exports = (subscribe, publish, edge, context) -> 

    require('../lib/viewport-protocol')(subscribe, publish, edge, context)
    require('../lib/controller-protocol')(subscribe, publish, edge, context)
