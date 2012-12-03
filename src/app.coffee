express = require 'express'
routes = require __dirname + '/routes'
http = require 'http'
path = require 'path'

app = express()

app.configure ->
    #
    # most of this came from the express scaffold
    # not too sure what some of it does (??)
    #
    app.set 'port', process.env.PORT || 3000
    app.set 'views', __dirname + '/../views'
    app.set 'view engine', 'jade'
    app.use express.favicon() 
    app.use express.logger('dev')
    app.use express.bodyParser() # ?? 
    app.use express.methodOverride() # ?? 
    app.use express.cookieParser('your secret here') # ??
    app.use express.session() # ??
    app.use app.router # ??
    app.use require('stylus').middleware(__dirname + '/../public')
    app.use express.static( path.join( __dirname, '/../public' ))

app.configure 'development', ->
    console.log "DEV"
    app.use express.errorHandler()

app.get '/', routes.index

http.createServer(app).listen app.get('port'), ->
    console.log 'Express server listening on port ' + app.get('port')
