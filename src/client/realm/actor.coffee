if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 

    class Actor

        constructor: (globals, @ui, config) ->

            @actor = true

            for key of config

                @[key] = config[key]