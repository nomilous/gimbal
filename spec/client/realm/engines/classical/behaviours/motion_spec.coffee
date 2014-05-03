{ipso, mock} = require 'ipso'

describe 'Motion', -> 
    
    before ipso (Motion) -> 

        globals = mock('globals')
        ui = mock('ui')
        config = mock('config')
    

    it '', ipso (globals, ui, config, Motion) -> 

        console.log Motion