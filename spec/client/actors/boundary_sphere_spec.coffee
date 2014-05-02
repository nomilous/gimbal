{ipso, mock} = require 'ipso'

describe 'BoundarySphere', -> 

    beforeEach ipso -> 

        mock('THREE').with
            Mesh: ->
            SphereGeometry: ->
            MeshNormalMaterial: ->

    it 'creates a three sphere and inserts it into the scene', 

        ipso (facto, THREE, BoundarySphere) -> 

            THREE.does

                Mesh: ->
                SphereGeometry: ->
                MeshNormalMaterial: ->

            bs = new BoundarySphere THREE:THREE, {}, {}

            bs.onVisRegister scene: add:-> facto()

