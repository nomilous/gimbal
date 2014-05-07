{ipso} = require 'ipso'

describe 'AsState', -> 

    it 'can set a state', 

        ipso (AsState) -> 

            class Test
                constructor: -> 
                    AsState.call @, 'thing'

            t = new Test

            t.thing.set 'state'
            t.thing.get.should.equal 'state'


    it 'knows when a state did not change', 

        ipso (AsState) -> 

            class Test
                constructor: -> 
                    AsState.call @, 'thing'

            t = new Test

            t.thing.set 'state'
            t.thing.set 'state'

            t.thing.changed.should.equal false


    it 'knows when a state did change', 

        ipso (AsState) -> 

            class Test
                constructor: -> 
                    AsState.call @, 'thing'

            t = new Test

            t.thing.set 'state1'
            t.thing.set 'state2'

            t.thing.changed.should.equal true

