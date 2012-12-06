express    = require 'express'
http       = require 'http'
path       = require 'path'

RedisStore = require('connect-redis')(express)
redis      = require("redis").createClient()

Db         = require('mongodb').Db
Connection = require('mongodb').Connection
Server     = require('mongodb').Server
BSON       = require('mongodb').BSON
ObjectID   = require('mongodb').ObjectID

ebb        = require('./ebb')

passport   = require('passport')
LocalStrategy = require('passport-local').Strategy
# OAuthStrategy = require('passport-oauth').OAuthStrategy

user = 
    id: '12345'
    username: 'test'
    password: 'ing'
    
passport.use new LocalStrategy (username, password, done) ->
    console.log 'Passport validating', username, password
    # done err
    if username == user.username and password == user.password
        return done null, user
    done null, false,
        message: 'Invalid username or password.'

passport.serializeUser (user, done) -> 
    console.log 'Passport serializing', user, 'to session'
    done null, user.id

passport.deserializeUser (id, done) -> 
    console.log 'Passport deserialize', id, 'from session'
    # pretend get user from db
    err = null
    done err, user


routes     = require __dirname + '/routes'
templates  = require __dirname + '/routes/templates'

app        = express()


app.configure ->

    app.use express.cookieParser()
    app.use express.session
        secret: process.env.CLIENT_SECRET or 'secret'
        maxAge : new Date Date.now() + 7200000
        store: new RedisStore {client: redis}
    app.use express.query()

    app.use passport.initialize()
    app.use passport.session()

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

    app.use ebb.configure app, 
        actors : require './models/actor'


app.configure 'development', ->

    app.use express.errorHandler()


app.post '/login', passport.authenticate('local'), (req, res) -> 
    res.send( JSON.stringify user )
app.get '/', routes.index
app.get '/templates/:template', templates.render


http.createServer(app).listen app.get('port'), ->
    console.log 'Express server listening on port ' + app.get('port')



# #
# # Heroku redistogo connection
# #
# if process.env.REDISTOGO_URL
#   rtg   = require('url').parse process.env.REDISTOGO_URL
#   redis = require('redis').createClient rtg.port, rtg.hostname
#   redis.auth rtg.auth.split('username:password')[1]
# else
#   redis = require("redis").createClient()

