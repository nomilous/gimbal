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
      'bundle.js',  # browserify -r three > lib/client/bundle.js
      'main.js'
    ]


app.get '/', (req, res) -> 

    res.send """

    <body>
        <script src="/js/bundle.js"></script>
        <script src="/js/main.js"></script>
    </body>

    """





app.listen 3000
