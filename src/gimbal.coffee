path     = require 'path'
express  = require 'express'
app      = express()

#
# export selected scripts from /lib/client as web /js
#

packager = new (require('cetera').Packager)
packager.mount
    app: app
    name: 'client'
    src: path.join __dirname, '/client'
    scripts: [

        'actors/actors.js'
        'actors/boundary_sphere.js'
        'actors/spherical_mass.js'

        'hud/hud_visible.js'

        'realm/engines/classical/classical_mechanics.js'
        'realm/engines/classical/behaviours/behaviours.js'
        'realm/engines/classical/behaviours/existance.js'
        'realm/engines/classical/behaviours/motion.js'
        'realm/engines/classical/behaviours/gravitation.js'
        'realm/engines/classical/behaviours/collision.js'

        'realm/ui/user_interface.js'
        'realm/visualizer/web_g_l_visualizer.js'
        'realm/actor.js'
        'realm/realm.js'

        'tools/tools.js'
        'tools/as_event_generator.js'
        #'tools/as_named_store.js'
        'tools/as_just_in_time.js'
        'tools/as_state.js'
        'tools/as_delta_state.js'
        'tools/as_Collision_detector.js'

        'main.js'
    ]


app.get '/', (req, res) -> 

    res.send """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <title>gimbal</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
        <link rel="stylesheet" href="/css/main.css">
    </head>
    <body>
        <script src='/js/require.js' data-main="/client/main"></script>
        <div class="ui"><div>    
    </body>
    </html>
    """


app.use express.static path.normalize __dirname + '/../public'


app.listen process.env.WWW_PORT || 3000, 'localhost'

console.log "http://localhost:#{process.env.WWW_PORT || 3000}"
