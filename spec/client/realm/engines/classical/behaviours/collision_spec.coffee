{ipso, mock} = require 'ipso'

describe 'Collision', -> 
    
    before ipso (Motion) -> 

        globals = mock('globals')
        ui = mock('ui')
        config = mock('config')
    

    it '', ipso (globals, ui, config, Collision) -> 

        console.log Collision