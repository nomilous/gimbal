if typeof define isnt 'function' then define = require('amdefine')(module)

define [

    './as_event_generator.js'
    #'./as_named_store.js'


], (

    AsEventGenerator
    #AsNamedStore

) -> 

    AsEventGenerator: AsEventGenerator
    #AsNamedStore: AsNamedStore

    