if typeof define isnt 'function' then define = require('amdefine')(module)

define -> (storename) ->

    #
    # When calling:
    # 
    # AsNamedStore.call( object, 'group' )
    #
    # Will provide:
    # 
    # object.create_group(  'name', value  )
    #
    # Which will create:
    #
    # object.group.name   (returning value)
    #

    if typeof @[storename] is 'undefined'

        @['AsNamedStore_' + storename] = []
        @[storename] = {}


    @['create_' + storename] = (name, value) ->

        i = @['AsNamedStore_' + storename].push [name, value]
        @[storename][name] = @['AsNamedStore_' + storename][i-1][1]