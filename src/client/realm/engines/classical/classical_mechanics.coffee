if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 

    class ClassicalMechanics

        constructor: (globals, @ui, config = {}) ->

            #globals.tools.AsNamedStore.call @, 'behaviours'
            @behaviours = {}


            @token = 

                cycle:  0
                time:   config.time || 1.0
                paused: config.paused || false
                count:  0
                actors: null

            @ui.token = @token


        registerBehaviour: (behaviour) ->

            #this.create_behaviours behaviour.name, behaviour
            @behaviours[behaviour.name] = behaviour


        registerActor: (actor, token) ->

            token ||= @token

            for name of @behaviours

                behaviour = @behaviours[name]

                #
                # actors can disable behaviour by specifying 
                # <behaviourname>: false
                #

                continue if actor[behaviour.name]? and not actor[behaviour.name]

                #
                # some behaviours require no registration
                #

                continue unless typeof behaviour.registerActor is 'function'

                behaviour.registerActor token, actor


        mainloop: (actors) ->

            return if @token.paused

            @token.cycle++

            @token.count  = actors.length
            @token.actors = actors

            @accumulate @token
            @apply @token


        accumulate: (token) -> 

            # 
            # Behaviour Controllers should use this pass
            # to accumulate the interactive influences
            # between actors in the system.
            # 
            # eg. Accumulate force of gravity between all
            #     pairs in the system
            # 


        apply: (token) ->

            #
            # Applies time to this cycle.
            #
            # In two object bound calls:
            # 
            # - applyQuadratic()
            #
            #   Behaviour controllers should use
            #   their applyQuadratic() to decompose
            #   second order physical interactive
            #   accumulations into the first order
            #   properties they influence.
            # 
            #   eg. Converting forces into velocty change.
            #      
            # - applyLinear()
            #
            #   eg. Converting velocity into position
            #

            for actor in token.actors

                continue unless actor.enabled

                for name of @behaviours

                    behaviour = @behaviours[name]

                    if typeof behaviour.applyQuadratic is 'function'

                        behaviour.applyQuadratic token, actor

                    if typeof behaviour.applyLinear is 'function'

                        behaviour.applyLinear token, actor


