{ipso, mock} = require 'ipso'

describe 'WebGLVisualizer', -> 

    before ipso -> 

        body = mock('body').with
            appendChild: ->

        mock('document').with
            createElement: -> {}
            body: body

        mock 'THREE'
        mock 'ui'

    beforeEach ipso (document, THREE) -> 

        mock('globals').with

            document: document
            THREE: THREE


    it 'appends container to document at construction', 

        ipso (globals, ui, WebGLVisualizer) -> 

            globals.document.does createElement: -> 1 
            globals.document.body.does appendChild: (child) ->
                child.should.equal 1

            new WebGLVisualizer globals

        