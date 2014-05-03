if typeof define isnt 'function' then define = require('amdefine')(module)

define -> (indexname, fn) ->

    #
    # When:
    #
    # collection.name_of_array exists and contains
    # an array of objects with an id property
    #
    # Then calling:
    # 
    #   (to generate the indexing facilities)
    #   AsOrderedPairIndexer.call( collection, 'function', function(a,b) { } )
    # 
    # Will provide:
    #
    #   collection.pair.name_of_array( version, a, b )
    #
    #   returns the result of the original function
    #
    #   where a and b are objects from the objects in name_of_array
    #
    #   (version, b, a) will return nothing
    #
    
    # 
    #   IF version does not correspond with the indexed version
    #   then ONLY the specified pair will be recomputed through 
    #   func and the new result stored against the new version
    #

    @[indexname] = index: [], function: fn


    @pair = _self: @ unless @pair?


    @get_indexed = (pass_through, indX, index, version, a, b) ->

        indX[a.id] = [] unless indX[a.id]?

        unless indX[a.id][b.id]?

            #
            # value not preset, compute and return
            #

            indX[a.id][b.id] = [version, 

                @[index].function(pass_through, a, b)

            ]

            return indX[a.id][b.id][1]


        previous = indX[a.id][b.id]
        return previous[1] if previous[0] == version


        indX[a.id][b.id] = [version, 

            #
            # providing allocated previous value for reuse
            # 

            @[index].function(pass_through, a, b, previous[1])

        ]

        return indX[a.id][b.id][1]


    @pair[indexname] = (pass_through, version, a, b) ->

        @_self.get_indexed(

            pass_through,
            @_self[indexname].index,
            indexname,
            version,
            a, b

        )
