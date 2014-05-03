{ipso} = require 'ipso'

describe 'AsNamedStore', -> 

    it 'creates an object for each store', 

        ipso (should, AsNamedStore) -> 

            class Test
                constructor: -> 
                    AsNamedStore.call @, 'things'

            t = new Test
            should.exist t.things
            t.things.should.be.an.instanceof Object


    it 'creates an array for each store', 

        ipso (should, AsNamedStore) -> 

            class Test
                constructor: -> 
                    AsNamedStore.call @, 'things'

            t = new Test
            should.exist t.AsNamedStore_things
            t.AsNamedStore_things.should.be.an.instanceof Array


    it 'creates a registrar function to create named stores', 

        ipso (should, AsNamedStore) -> 

            class Test
                constructor: ->
                    AsNamedStore.call @, 'things'

            t = new Test
            should.exist t.create_things
            t.create_things.should.be.an.instanceof Function


    it 'can store values', 

        ipso (should, AsNamedStore) -> 

            class Test
                constructor: ->
                    AsNamedStore.call @, 'things'

            t = new Test

            t.create_things 'name', 'value'
            t.AsNamedStore_things.should.eql [['name','value']]


    it 'can retreive values', 

        ipso (should, AsNamedStore) -> 

            class Test
                constructor: ->
                    AsNamedStore.call @, 'things'

            t = new Test
            t.create_things 'name', 'value'
            should.exist t.things.name
            t.things.name.should.equal 'value'

