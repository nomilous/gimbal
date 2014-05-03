{ipso, mock} = require 'ipso'

describe 'Gravitation', -> 
    
    before ipso (Motion) -> 

        globals = mock('globals')
        ui = mock('ui')
        config = mock('config')
    

    it '', ipso (globals, ui, config, Gravitation) -> 

        console.log Gravitation