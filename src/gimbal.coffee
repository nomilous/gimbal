require('vertex').create

    www: 
        listen: port: 3000
        allowRoot: 'true'
        routes: root = (opts, callback) -> 

            callback null, 'okgood'


root.$www = {}
