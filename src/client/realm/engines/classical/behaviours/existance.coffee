if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 


    class Existance


        constructor: ({@THREE, tools}) ->
            
            @name = 'existance'
            {@AsJustInTime, @AsDeltaState} = tools


        registerActor: (token, actor) ->

            #
            # existance creates mass and position onto actor
            #

            actor.exists     = true
            actor.mass     ||= 1.0
            actor.position ||= new @THREE.Vector3 0, 0, 0
            # actor.history  ||= {}
            # actor.history.length = 3
            # actor.history.position = []

            unless token.pair? and token.pair.range_vector?

                #
                # Provide a JustInTime index on vector distance between pairs,
                # The JustInTime allows for computing the distance only on the 
                # first call per cycle and storing the value for subsequent calls 
                #

                @AsJustInTime.call token, 'range_vector', 

                    (token, a, b, previous) -> 

                        #
                        # high throughput call, reusing previous to save on allocation time
                        #

                        previous = a.position.clone() unless previous?

                        #
                        # subtract b's position from a's
                        # 

                        previous.copy( a.position ).sub( b.position )

                        return previous

            unless token.pair.range_scalar?

                #
                # Provide a JustInTime with StateDelta on distance between Actors
                #

                @AsJustInTime.call token, 'range_scalar',

                    (token, a, b, previous) => 

                        unless previous

                            previous = {}

                            @AsDeltaState.call previous, 'range'


                        range_vector = token.pair.range_vector token, token.cycle, a, b

                        distance = Math.sqrt range_vector.dot range_vector

                        previous.range.set distance

                        return previous

        preSet: (token, actor) ->

            return unless actor.exists
            # actor.history.position.unshift actor.position.clone()

            # while actor.history.position.length > actor.history.length
            #     actor.history.position.pop()



