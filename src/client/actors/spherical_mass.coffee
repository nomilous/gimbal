if typeof define isnt 'function' then define = require('amdefine')(module)

define ['../hud/hud_visible.js'], (HudVisible) -> 


    class SphericalMass extends HudVisible


        constructor: (globals, @ui, config) ->

            super globals, @ui, config

            @sphericalmass = true

            {@THREE} = globals

            @radius   ||= Math.sqrt( @mass ) / 10;
            @segments ||= 20
            @rings    ||= 20
            @material ||= {}
            @material.color ||= 0x777777
            @position ||= new @THREE.Vector3 0.0, 0.0, 0.0

            if @light?

                #
                # this is a light source
                #

                @light.color ||= 0xFFFFFF 


        onVisRegister: (visualizer) -> 

            {
                MeshLambertMaterial,
                MeshNormalMaterial,
                SphereGeometry,
                Mesh,
                PointLight
            } = @THREE

            if @light?
                material = new MeshNormalMaterial @material
            else 
                material = new MeshLambertMaterial @material

            geometry = new SphereGeometry @radius, @segments, @rings
            @GLobject = new Mesh geometry, material
            @GLobject.position = @position
            visualizer.scene.add @GLobject

            if @light?

                @GLobject_as_light = new PointLight @light.color
                @GLobject_as_light.position = @position
                visualizer.scene.add @GLobject_as_light