if typeof define isnt 'function' then define = require('amdefine')(module)

define [

    './as_event_generator.js'
    #'./as_named_store.js'
    './as_just_in_time.js'
    './as_state.js'
    './as_delta_state.js'
    './as_collision_detector.js'


], (

    AsEventGenerator
    #AsNamedStore
    AsJustInTime
    AsState
    AsDeltaState
    AsCollisionDetector

) -> 

    AsEventGenerator: AsEventGenerator
    #AsNamedStore: AsNamedStore
    AsJustInTime: AsJustInTime
    AsState: AsState
    AsDeltaState: AsDeltaState
    AsCollisionDetector: AsCollisionDetector AsJustInTime, AsState

    