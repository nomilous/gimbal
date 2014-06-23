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

app.set 'view engine', 'jade'

app.get '/', (req, res) -> res.render 'index'

app.use express.static path.normalize __dirname + '/../public'

app.listen process.env.WWW_PORT || 3000, 'localhost'

console.log "http://localhost:#{process.env.WWW_PORT || 3000}"
