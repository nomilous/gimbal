if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 

    class WebGLVisualizer

        constructor: ({window, document, THREE}, @ui, config = {}) -> 

            @container = document.createElement 'div'
            document.body.appendChild @container

            @scene = new THREE.Scene

            @camera = new THREE.PerspectiveCamera(

                config.fov  || 70.0,
                window.innerWidth / window.innerHeight,
                config.near || 1.0,
                config.far  || 10000.0

            )

            @scene.add @camera

            @renderer = new THREE.WebGLRenderer
            @renderer.setSize window.innerWidth, window.innerHeight
            @renderer.setClearColor( 

                config.clearColor || 0x000000,
                config.clearAlpha || 1

            )

            @container.appendChild @renderer.domElement