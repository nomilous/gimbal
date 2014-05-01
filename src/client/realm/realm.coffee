if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 

    class Realm

        constructor: (globals, @ui, config) -> 

            @ui.realm   = @
            @engine     = config.engine
            @visualizer = config.visualizer

        exist: ->

            

            

