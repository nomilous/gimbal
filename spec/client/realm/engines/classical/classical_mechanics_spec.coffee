{ipso} = require 'ipso'

describe 'ClassicalMechanics', -> 


    it """creates a token with a cycle counter, timestep, 
          paused flag and count of actors""", 

            ipso (ClassicalMechanics) -> 

                {token} = new ClassicalMechanics {}, {}, 

                    time: 1
                    paused: true

                token.cycle.should.equal 0
                token.time.should.equal 1
                token.paused.should.equal true
                token.count.should.equal 0


    it 'shares the token onto the ui', 

        ipso (ClassicalMechanics, should) -> 

            ui = {}

            new ClassicalMechanics {}, ui

            should.exist ui.token

