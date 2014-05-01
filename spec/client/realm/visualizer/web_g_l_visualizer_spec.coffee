{ipso, mock} = require 'ipso'

describe 'WebGLVisualizer', -> 


    before ipso -> 

        mock('window').with
            innerWidth: 100
            innerHeight: 50

        body = mock('body').with
            appendChild: -> 

        mock('document').with
            createElement: -> appendChild: ->
            body: body

        mock('THREE').with 
            Scene: -> add: ->
            PerspectiveCamera: ->
            WebGLRenderer: -> 
                setSize: ->
                setClearColor: ->


        mock 'ui'


    beforeEach ipso (window, document, THREE) -> 

        mock('globals').with

            window: window
            document: document
            THREE: THREE


    it 'appends container to document at construction', 

        ipso (globals, ui, WebGLVisualizer) -> 

            globals.document.does _createElement: ->  
            globals.document.body.does appendChild: ->

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
                    aspect.should.equal 100 / 50
                    near.should.equal 1
                    far.should.equal 10000

            new WebGLVisualizer globals, ui


    it 'creates a new camera with specified config', 

        ipso (globals, ui, WebGLVisualizer) ->

            globals.THREE.does

                PerspectiveCamera: (fov, aspect, near, far) -> 

                    fov.should.equal 100
                    aspect.should.equal 100 / 50
                    near.should.equal 1
                    far.should.equal 10000

            new WebGLVisualizer globals, ui, 

                fov: 100


    it 'creates a new renderer with config and sets size', 

        ipso (globals, ui, WebGLVisualizer) -> 

            globals.THREE.does

                WebGLRenderer: -> 
                    
                    return mock('renderer').does 

                        setSize: (width, height) ->

                            width.should.equal 100
                            height.should.equal 50

                        setClearColor: ->


            new WebGLVisualizer globals, ui, 

                clearColor: 0x000000









