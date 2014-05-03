if typeof define isnt 'function' then define = require('amdefine')(module)

define ['../hud/hud_visible.js'], (HudVisible) -> 


    class BoundarySphere extends HudVisible


        constructor: (globals, @ui, config) ->

            super globals, @ui, config

            @boundarysphere = true

            {@THREE} = globals

            @radius   ||= 500
            @segments ||= 30
            @rings    ||= 30
            @material ||= {}
            @material.wireframe ||= true
            @material.wireframeLinewidth ||= 1
            @material.opacity ||= 0.15
            @position ||= new @THREE.Vector3 0.0, 0.0, 0.0


        onVisRegister: (visualizer) ->

            {Mesh, SphereGeometry, MeshNormalMaterial} = @THREE

            geometry  = new SphereGeometry @radius, @segments, @rings
            material  = new MeshNormalMaterial @material
            @GLobject = new Mesh geometry, material

            visualizer.scene.add @GLobject
            @GLobject.position = @position

