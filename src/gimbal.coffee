module.exports = (req, res, next) -> 

    return next() unless req.url == '/gimbal.js'
    
    res.send 'pending gimbal scripts'
