if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 


    class Gravitation


        constructor: ({@THREE}, @ui, config = {})->

            @name = 'gravitation'
            @G = config.G || 1.0


        registerActor: (token, actor) ->

            return unless actor.gravitation?
            actor.force = {} unless actor.force?
            actor.force.gravity = new @THREE.Vector3 0, 0, 0


        preSet: (token, actor) ->

            return unless actor.gravitation?
            actor.force.gravity.set 0, 0, 0


        accumulate: (token, actor1, actor2) ->

            return if not actor1.gravitation?
            return if not actor2.gravitation?

            range_vector = token.pair.range_vector(

                token,
                token.cycle,
                actor1,
                actor2

            )

            gravity  = range_vector.clone()
            rSquared = gravity.dot gravity
            scalarG  = this.G * actor1.mass * actor2.mass / rSquared
            scalarD  = Math.sqrt rSquared

            gravity.multiplyScalar scalarG / scalarD

            actor1.force.gravity.sub gravity
            actor2.force.gravity.add gravity


        applyQuadratic: (token, actor) ->

            return unless actor.gravitation?

            actor.force.gravity.multiplyScalar token.time
            actor.force.gravity.divideScalar actor.mass
            actor.velocity.add actor.force.gravity

