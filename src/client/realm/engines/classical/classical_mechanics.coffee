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

            #@token.count  = actors.length
            @token.actors = actors

            @preSet @token
            @accumulate @token
            @apply @token


        preSet: (token) ->

            for name of @behaviours

                behaviour = @behaviours[name]

                continue unless behaviour.preSet?

                for actor in token.actors

                    continue unless actor.enabled

                    behaviour.preSet token, actor


        accumulate: (token) ->

            # 
            # Behaviour Controllers should use this pass
            # to accumulate the interactive influences
            # between actors in the system.
            # 
            # eg. Accumulate force of gravity between all
            #     pairs in the system
            # 

            `
            var i, j, behaviour;
                    
            for( i = 0; i < token.actors.length; i++ ) {
                
                if( !token.actors[i].enabled )
                
                    continue;
                
                for( j = token.actors.length; --j > i; ) { 
                    
                    // Each possible object pair, only once
                    //
                    //
                    //    (cant seem to do --j on for loop in coffeescript)
                    //
                    
                    if( !token.actors[j].enabled )

                        continue;
                        
                    
                    // actors in the same group do not interact
                    
                    if( token.actors[i].groupid == token.actors[j].groupid )

                        continue;
                    
                
                    for( var name in this.behaviours ) {

                        behaviour = this.behaviours[name];
                        
                        if( behaviour.accumulate == undefined ) 
                        
                            continue;
                        
                        behaviour.accumulate(
                             
                            token,
                            token.actors[i], 
                            token.actors[j]
                            
                        );
                    }
                }
            }
            `
            return


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


