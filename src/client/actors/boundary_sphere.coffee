if typeof define isnt 'function' then define = require('amdefine')(module)

define ['../realm/actor'], (Actor) -> 

    class BoundarySphere extends Actor

        constructor: ({@THREE}, @ui, config) ->

            @boundarysphere = true
            @radius   = config.radius   || 500
            @segments = config.segments || 30
            @rings    = config.rings    || 30
            @material = 
                wireframe: true
                wireframeLinewidth: 1
                opacity: 0.15


        onVisRegister: (visualizer) -> 

            @GLobject = new @THREE.Mesh(

                new @THREE.SphereGeometry @radius, @segments, @rings
                new @THREE.MeshNormalMaterial @material

            )

            visualizer.scene.add @GLobject
