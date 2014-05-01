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
        'realm/engines/classical/classical_mechanics.js',
        'realm/visualizer/web_g_l_visualizer.js'
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
        <style>
            body {
                background-color: #555555;
                margin: 0px;
                overflow: hidden;
            }
        </style>
    </head>
    <body>
        <script src='/js/require.js' data-main="/js/main"></script>
    </body>
    </html>
    """





app.listen 3000
