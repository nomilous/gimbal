{ipso} = require 'ipso'

describe 'Actor', -> 

    it 'assigs values from config', ipso (Actor) -> 

        a = new Actor {}, {}, key: 'Value'
        a.key.should.equal 'Value'

