if typeof define isnt 'function' then define = require('amdefine')(module)

define [

    './as_event_generator.js'
    #'./as_named_store.js'
    './as_just_in_time.js'


], (

    AsEventGenerator
    #AsNamedStore
    AsJustInTime

) -> 

    AsEventGenerator: AsEventGenerator
    #AsNamedStore: AsNamedStore
    AsJustInTime: AsJustInTime

    