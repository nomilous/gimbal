{ipso, mock} = require 'ipso'

describe 'Existance', -> 
    
    before ipso (Existance) -> 

        globals = mock('globals')
        ui = mock('ui')
        config = mock('config')
    

    it '', ipso (globals, ui, config, Existance) -> 

        console.log Existance
        