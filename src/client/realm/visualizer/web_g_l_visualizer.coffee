if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 

    class WebGLVisualizer

        constructor: ({document, THREE}, @ui, config) -> 

            @container = document.createElement 'div'
            document.body.appendChild @container

