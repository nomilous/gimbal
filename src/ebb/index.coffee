class Ebb

    @configure : (conf) -> 

        console.log "Ebb.configure()", conf
        
        return (req, res, next) -> 

            #
            # do nothing, pass to next handler
            # 

            next()


module.exports = Ebb
