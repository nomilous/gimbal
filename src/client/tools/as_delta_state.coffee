if typeof define isnt 'function' then define = require('amdefine')(module)

define -> (name) ->

    #
    # When called:
    # 
    # AsDeltaState.call( object, 'changingThing' )
    #
    # Will provide:
    #
    # - To update the state
    # 
    #   object.changingThing.set( 'state' )
    # 
    # - To query whether or not the new value as, .set(), changed the state
    # 
    #   (boolean) object.changingThing.changed
    #
    # - To get the state value, as .set(.)
    # 
    #   (object) object.changingThing.get
    #
    # - To get the delta of the change
    #
    #  (number) object.changedThing.delta
    #
    
    @[name] = 

        name: name

        set: (nextState) -> 

            if @get is null

                @get = nextState
                @delta = nextState
                return

            if @get == nextState

                @changed = false
                @delta = 0
                return

            @delta = nextState - @get
            @get = nextState
            @changed = true
            return

        get: null

        changed: false