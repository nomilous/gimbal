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

        registerActor: (actor) ->