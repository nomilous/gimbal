class Ebb

    @render : (req, res) -> 

        res.send req.ebb.model.get( req.ebb.id )


    @gotModel : (req) ->

        route = req.path.match /^\/(\w{1,})\/(\S{1,})/ 
        return false unless @models[ route[1] ] and route[2]
        
        req['ebb'] = 
            model: @models[ route[1] ]
            id: route[2]

        return true


    @configure : (app, @models) -> 

        @env = app.get 'env'
        console.log "Ebb.configure()", @env, @models

        return (req, res, next) => 
            #return next() unless req.is 'json'
            #return next() unless req.is 'application/json'
            return next() unless @gotModel req
            @render req, res


module.exports = Ebb
