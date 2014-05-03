if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 


    class Existance


        constructor: ({@THREE}) ->
            
            @name = 'existance'


        registerActor: (token, actor) ->

            #
            # existance creates mass and position onto actor
            #

            actor.exists     = true
            actor.mass     ||= 1.0
            actor.position ||= new @THREE.Vector3 0, 0, 0

