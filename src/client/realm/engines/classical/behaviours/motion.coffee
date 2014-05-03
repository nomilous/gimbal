if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 

    class Motion

        constructor: ({@THREE}) ->

            @name = 'motion'

        registerActor: (token, actor) ->

            #
            # motion creates velocity onto actor
            #

            actor.moves = true
            actor.velocity ||= new @THREE.Vector3 0, 0, 0


        applyLinear: (token, actor) -> 

            #
            # displaces the actor according to time and velocity
            #

            displace = actor.velocity.clone()
            displace.multiplyScalar token.time
            actor.position.add displace
