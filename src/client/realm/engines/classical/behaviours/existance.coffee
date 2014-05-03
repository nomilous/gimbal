if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 


    class Existance


        constructor: ({@THREE, tools}) ->
            
            @name = 'existance'
            {@AsJustInTime} = tools


        registerActor: (token, actor) ->

            #
            # existance creates mass and position onto actor
            #

            actor.exists     = true
            actor.mass     ||= 1.0
            actor.position ||= new @THREE.Vector3 0, 0, 0

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

