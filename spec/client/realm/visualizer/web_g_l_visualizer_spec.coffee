{ipso, mock} = require 'ipso'

describe 'WebGLVisualizer', -> 


    before ipso -> 

        mock('window').with
            innerWidth: 100
            innerHeight: 40

        body = mock('body').with
            appendChild: ->

        mock('document').with
            createElement: -> {}
            body: body

        mock('THREE').with 
            Scene: -> add: ->
            PerspectiveCamera: ->


        mock 'ui'


    beforeEach ipso (window, document, THREE) -> 

        mock('globals').with

            window: window
            document: document
            THREE: THREE


    it 'appends container to document at construction', 

        ipso (globals, ui, WebGLVisualizer) -> 

            globals.document.does createElement: -> 1 
            globals.document.body.does appendChild: (child) ->
                child.should.equal 1

            new WebGLVisualizer globals, ui


    it 'creates a new scene', 

        ipso (globals, ui, WebGLVisualizer) -> 

            globals.THREE.does Scene: -> add: ->

            new WebGLVisualizer globals, ui


    it 'creates a new camera with defaults', 

        ipso (globals, ui, WebGLVisualizer) -> 

            globals.THREE.does 

                PerspectiveCamera: (fov, aspect, near, far) -> 

                    fov.should.equal 70
                    aspect.should.equal 2.5
                    near.should.equal 1
                    far.should.equal 10000

            new WebGLVisualizer globals, ui


    it 'creates a new camera with specified config', 

        ipso (globals, ui, WebGLVisualizer) ->

            globals.THREE.does 

                PerspectiveCamera: (fov, aspect, near, far) -> 

                    fov.should.equal 100
                    aspect.should.equal 2.5
                    near.should.equal 1
                    far.should.equal 10000

            new WebGLVisualizer globals, ui, 

                fov: 100




