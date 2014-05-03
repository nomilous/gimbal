{ipso, mock} = require 'ipso'

describe 'ClassicalMechanics', -> 

    before ipso -> 

        mock('globals')


    it """creates a token with a cycle counter, timestep, 
          paused flag and count of actors""", 

            ipso (globals, ClassicalMechanics) -> 

                {token} = new ClassicalMechanics globals, {}, 

                    time: 1
                    paused: true

                token.cycle.should.equal 0
                token.time.should.equal 1
                token.paused.should.equal true
                token.count.should.equal 0


    it 'shares the token onto the ui', 

        ipso (globals, ClassicalMechanics, should) -> 

            ui = {}
            new ClassicalMechanics globals, ui

            should.exist ui.token


    it 'can register behaviours', 

        ipso (globals, ClassicalMechanics, should) -> 

            ui = {}
            cm = new ClassicalMechanics globals, ui
            cm.registerBehaviour name: 'existance'

            cm.behaviours.existance.should.eql name: 'existance'


    it 'registers actors with behaviour', 

        ipso (facto, globals, ClassicalMechanics, should) -> 

            ui = {}
            cm = new ClassicalMechanics globals, ui
            cm.registerBehaviour 

                name: 'existance'
                registerActor: -> facto()

            cm.registerActor {}
