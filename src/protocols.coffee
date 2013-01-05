module.exports = (subscribe, publish, edge, context) -> 

    #
    console.log 'TODO: switch these to ../lib/.. before release'
    #

    require('../src/viewport-protocol')(subscribe, publish, edge, context)
    require('../src/controller-protocol')(subscribe, publish, edge, context)
