express    = require 'express'
http       = require 'http'
path       = require 'path'

Db         = require('mongodb').Db
Connection = require('mongodb').Connection
Server     = require('mongodb').Server
BSON       = require('mongodb').BSON
ObjectID   = require('mongodb').ObjectID


#
# This module is being developed inline
# 
et         = require 'et'
# 
# cd node_modules
# git clone git@github.com:nomilous/et.git
# 

routes     = require __dirname + '/routes'
templates  = require __dirname + '/routes/templates'

app        = express()


app.configure ->

    app.use et.al
        app: app
        session: require './config/session'
        models: require './models'
        auth:
            validator: (user, pass) -> 
                user: user
                info: 'fake auth, pending user model later'
                id: '1'


    app.use express.query()

    app.set 'port', process.env.PORT || 3000
    app.set 'views', __dirname + '/../views'
    app.set 'view engine', 'jade'

    app.use express.favicon() 
    app.use express.logger('dev')
    app.use express.bodyParser() # ?? 
    app.use express.methodOverride() # ?? 
    app.use app.router # ??

    app.use require('connect-assets')()
    app.use require('stylus').middleware(__dirname + '/../public')
    app.use express.static( path.join( __dirname, '/../public' ))

app.configure 'development', ->

    app.use express.errorHandler()


# app.post '/login', passport.authenticate('local'), (req, res) -> 
#     res.send( JSON.stringify user )
app.get '/', routes.index
app.get '/templates/:template', templates.render


http.createServer(app).listen app.get('port'), ->
    console.log 'Express server listening on port ' + app.get('port')

