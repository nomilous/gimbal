if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 

    class Realm

        constructor: (globals, @ui, config) -> 

            @ui.realm   = @
            @engine     = config.engine
            @visualizer = config.visualizer
            @actors     = []

        registerActor: (actor) -> 

            actor.id      = ++@actor_id_seq
            actor.groupid = actor.id
            actor.enabled = true

            @actors.push actor

            @engine.registerActor actor
            @visualizer.registerActor actor
            @ui.registerActor actor

        exist: ->

            @visualizer.render()

            

