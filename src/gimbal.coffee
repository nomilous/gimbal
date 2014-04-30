express = require 'express'
app     = express()

app.get '/', (req, res) -> 

    res.send 'ok good'


app.listen 3000
