path     = require 'path'
express  = require 'express'
app      = express()

#
# export selected scripts from /lib/client as web /js
#

packager = new (require('cetera').Packager)
packager.mount
    app: app
    name: 'js'
    src: path.join __dirname, '/client'
    scripts: [
      'require.js',
      'three.js',
      'realm/ui/user_interface.js',
      'realm/visualizer/web_g_l_visualizer.js'
      'main.js'
    ]


app.get '/', (req, res) -> 

    res.send """

    <body>
        <script src='/js/require.js' data-main="/js/main"></script>
    </body>

    """





app.listen 3000
