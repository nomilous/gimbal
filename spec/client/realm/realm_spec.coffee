{ipso, mock} = require 'ipso'

describe 'Realm', -> 

    before ipso (AsEventGenerator) -> 

        mock('globals').with

            tools: AsEventGenerator: AsEventGenerator

        mock('config').with

            visualizer: mock('visualizer').with

                registerActor: ->

            engine: mock('engine').with

                registerActor: ->

        mock('ui').with 

            registerActor: ->


    context 'registerActor', -> 


        it 'assigns an id and groupid to actor and sets the actor enabled', 

            ipso (globals, should, ui, config, Realm) -> 

                actor = {}
                realm = new Realm globals, ui, config
                realm.registerActor actor

                should.exist actor.id
                should.exist actor.groupid
                should.exist actor.enabled


        it 'inserts the actor into the actors array', 

            ipso (globals, ui, config, Realm) -> 

                actor = {}
                realm = new Realm globals, ui, config
                realm.registerActor actor

                realm.actors.length.should.equal 1


        it 'registers the actor with the simulation engine', 

            ipso (globals, engine, ui, config, Realm) -> 

                engine.does registerActor: -> 

                actor = {}
                realm = new Realm globals, ui, config
                realm.registerActor actor


        it 'registers the actor with the visualizer',

            ipso (globals, visualizer, ui, config, Realm) -> 

                visualizer.does registerActor: -> 

                actor = {}
                realm = new Realm globals, ui, config
                realm.registerActor actor


        it 'registers the actor with the ui',

            ipso (globals, ui, config, Realm) -> 

                ui.does registerActor: -> 

                actor = {}
                realm = new Realm globals, ui, config
                realm.registerActor actor
