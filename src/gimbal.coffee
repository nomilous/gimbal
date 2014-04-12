require('vertex').create

    www: 
        listen: port: 3000
        allowRoot: 'true'
        routes: require './routes'
