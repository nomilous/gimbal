{ipso} = require 'ipso'

describe 'UserInterface', ->

    it 'defines create', ipso (UserInterface) -> 

        console.log typeof UserInterface.create

