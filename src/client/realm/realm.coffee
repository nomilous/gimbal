if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 

    class Realm

        constructor: (globals, @ui, config) -> 

            @ui.realm   = @
            @engine     = config.engine
            @visualizer = config.visualizer
            @actors     = []

            # 
            # generates events onInsert and onDelete
            #

            globals.tools.AsEventGenerator.call @

        registerActor: (actor) -> 

            actor.id      = ++@actor_id_seq
            actor.groupid = actor.id
            actor.enabled = true

            @actors.push actor

            @engine.registerActor actor
            @visualizer.registerActor actor
            @ui.registerActor actor

            @notifyHandlers 'onInsert', actor


        deleteActor: (actor) -> 

            console.log 'todo: Realm.deleteActor'

            @notifyHandlers 'onDelete', actor

        exist: ->

            @visualizer.render()



