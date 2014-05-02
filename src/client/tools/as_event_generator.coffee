if typeof define isnt 'function' then define = require('amdefine')(module)

define -> ->

    #
    # When called:
    # 
    # AsEventGenerator.call( eventSource );
    #
    # Will provide:
    #
    # - To register event handlers
    # 
    #   eventSource.registerHandler( eventHandler )
    # 
    # - To raise events to all handlers
    # 
    #   eventSource.notifyHandlers( 'eventName', object )
    # 
    #      Will call:
    #
    #      eventHandler.eventName( object );
    #
    
    @handlers = []

    @registerHandler = (handler) => 

        @handlers.push handler

    