exports.render = (req, res) -> 

    res.render 'templates/' + req.params.template
