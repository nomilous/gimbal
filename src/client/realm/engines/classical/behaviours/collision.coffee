if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 


    class Collision


        constructor: ({@THREE, @tools}, @ui, config) ->

            @name = 'collision'


        registerActor: (token, actor) ->

            return unless actor.collision?

            @tools.AsCollisionDetector.call @, token unless token.detectCollision?

            actor.force ||= {}
            actor.force.impulse = new @THREE.Vector3 0, 0, 0
            actor.elasticity ||= 0 # 100% bounce in 1 engine cycle


        preSet: (token, actor) ->

            return unless actor.collision?

            actor.force.impulse.set 0, 0, 0


        # accumulate: (token, actor1, actor2) ->

        #     # return unless actor1.collision?
        #     # return unless actor2.collision?


        # applyQuadratic: (token, actor) ->


        postSet: (token, actor1, actor2) ->

            return unless actor1.collision?
            return unless actor2.collision?

            response = @detectCollision token, actor1, actor2, response

            return unless response.intersect.get

            impulse = @calculateImpulse token, actor1, actor2, response

            masssum = actor1.mass + actor2.mass

            @applyImpulse(

                token,
                impulse,

                #
                # proportion of energy lost to aceleratoing the
                # other during collision
                #

                actor2.mass / masssum
                actor1,
                actor1.id == response.lighter.id

            )

            @applyImpulse(

                token,
                impulse
                actor1.mass / masssum
                actor2,
                actor2.id == response.lighter.id
            )


        calculateImpulse: (token, actor1, actor2, response) ->

            #
            # calculate impulse required to reverse closing velocity
            # using the lighter mass
            #
            # pretend the object being bounced upon is of infinite mass
            # and therefore the bounce will entirely reverse the velocity
            # of the bouncing object
            #

            impulse_scalar = response.lighter.mass * response.closing * 2 / token.time


            #
            # use the velocity of the pairs average position as 
            # directional reference
            # 
            # 
            # frame = @pairVelocity actor1, actor2
            # 

            impulse_vector = token.pair.range_vector(

                token,
                token.cycle,
                if actor1.id == response.lighter.id then actor1 else actor2
                if actor1.id == response.lighter.id then actor2 else actor1

            ).clone()

            impulse_vector.normalize().multiplyScalar impulse_scalar

            return impulse_vector


        applyImpulse: (token, impulse, proportion, actor, reference) ->

            #
            # <proportion> ratio  : What proportion of the combined mass
            #                       of the pair belongs to the other 
            #                       object.
            #
            #
            # <reference> boolean : Was this actor the reference actor
            #                       used to calculate the impulse.
            #     
            #                       ie. Should the impulse be applied 
            #                           in reverse or not.
            #

            actor.force.impulse.copy impulse

            if reference then actor.force.impulse.negate()

            delta_velocity = actor.force.impulse.clone()

            delta_velocity.divideScalar actor.mass

            delta_velocity.multiplyScalar proportion

            actor.velocity.add delta_velocity

            delta_velocity.multiplyScalar token.time

            actor.position.add delta_velocity


        # pairVelocity: (a, b) ->

        #     previous = a.history.position[0].clone()
        #     previous.add b.history.position[0]
        #     previous.divideScalar 2

        #     current = a.position.clone()
        #     current.add b.position
        #     current.divideScalar 2

        #     return previous.sub current




