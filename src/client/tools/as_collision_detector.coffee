if typeof define isnt 'function' then define = require('amdefine')(module)

define -> (AsJustInTime, AsState) -> (token) ->

    #
    # Both actors are spheres.
    #
    # Requires:
    # 
    # - both Actors have <actor>.radius and <actor>.position
    # 
    #   Used directly for collision threshold
    #
    #   TODO   - both Actors specify <actor>.elasticity
    #
    #            Used to stretch the collision/impulse 
    #            over more than one engine cycle
    #         
    #            Implement later... #WHENTHERESAREASON1
    #
    # - token.pair.range_scalar contains a JustInTime
    #   index AsStateDelta to compute the actors' 
    #   position delta.
    #


    unless token.pair? and token.pair.intersect?

        AsJustInTime.call token, 'intersect', 

            (token, a, b, state) ->

                unless state?

                    state = {}

                    #
                    # Intersect (boolean)
                    # 
                    # Some portion of the boundry spheres between
                    # the pair are intersecting.
                    #

                    AsState.call state, 'intersect'

                    #
                    # Inside (boolean)
                    # 
                    # True of one object is inside the other
                    #

                    AsState.call state, 'inside'

                    #
                    # Lighter (Actor reference)
                    # 
                    # The lighter of the pair under collision
                    #

                    state.lighter = null

                    #
                    # Closing (Scalar number)
                    # 
                    # How fast were the colliders approaching
                    # before the collision
                    #

                    state.closing = null


                state.lighter = if a.mass < b.mass then a else b

                range_state = token.pair.range_scalar token, token.cycle, a, b

                state.closing = range_state.range.delta

                range = range_state.range.get

                intersect = a.radius + b.radius > range

                unless intersect

                    #
                    # Actors are entirely clear of each other
                    #

                    state.intersect.set intersect
                    state.inside.set false
                    return state

                #
                # Actors surfaces are either intesecting or they're 
                # entirely inside one another
                # 

                state.inside.set( 

                    #
                    # One actor is entirely inside the other
                    # if the biggest particles radius is 
                    # grater than the distance between 
                    # their centers
                    #

                    if a.radius < b.radius 

                        a.radius > range 

                    else 

                        a.radius > range

                )

                #
                # recalculate intersect in case of innersurface 
                #

                state.intersect.set(

                    if state.inside.get 

                        Math.abs( a.radius - b.radius ) < range

                    else

                        intersect

                )

                return state


    @detectCollision = (token, actor1, actor2) ->

        return token.pair.intersect token, token.cycle, actor1, actor2


