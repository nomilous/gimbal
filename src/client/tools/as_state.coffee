if typeof define isnt 'function' then define = require('amdefine')(module)

define -> (name) ->

    #
    # When called:
    # 
    # AsState.call( object, 'changingThing' )
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

    @[name] = 

        name: name

        set: (nextState) ->

            if @get is null

                #
                # new state
                #

                @get = nextState
                return @

            if @get == nextState

                #
                # no change
                #

                this.changed = false
                return @

            @get = nextState
            @changed = true
            return @

        get: null

        changed: false
