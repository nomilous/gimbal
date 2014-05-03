#
# Actors/Objects extend this behaviour 
# to become viewable in the 
# HeadsUpDisplay
#

if typeof define isnt 'function' then define = require('amdefine')(module)

define ['../realm/actor.js'], (Actor) -> 

    class HudVisible extends Actor

        constructor: (globals, @ui, config) ->

            super globals, @ui, config
            
            @hudvisible = true

