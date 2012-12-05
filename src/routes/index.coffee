exports.index = (req, res) -> 

    console.log 'SESSION:', req.session

    res.render 'index',

        title: 'gimbal'
