{ipso} = require 'ipso'

describe 'AsEventGenerator', -> 


    it 'assigns array to store handlers', 

        ipso (AsEventGenerator) ->  
    
            class Test
                constructor: -> 
                    AsEventGenerator.call @

            (new Test).handlers.should.be.an.instanceof Array


    it """creates a handler registration function that 
          stores the handler in the array""", 

        ipso (AsEventGenerator) -> 

            class Test
                constructor: -> 
                    AsEventGenerator.call @

            t = new Test
            t.registerHandler.should.be.an.instanceof Function
            t.registerHandler first: 'handler'

            t.handlers[0].should.eql first: 'handler'


    it 'calls the specified eventFunction on each handler',

        ipso (facto, AsEventGenerator) -> 

            class Test
                constructor: -> 
                    AsEventGenerator.call @

                moo: -> 
                    @notifyHandlers 'onMoo'

            t = new Test
            t.registerHandler onMoo: -> facto()
            t.moo()