which = require 'which' 
{spawn, exec} = require 'child_process'

log = (mess) ->
    console.log mess

build = ->
  options = ['-c','-b', '-o', 'app', 'src']
  cmd = which.sync 'coffee'
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  coffee.on 'exit', (status) -> 
    callback?() if status is 0

task 'dev', 'Start development environment', -> 

    #
    # run coffe with the switcheds to watch the 
    # src dir and compile as necessary
    #

    options = ['-c', '-b', '-w', '-o', 'app', 'src']
    cmd = which.sync 'coffee'
    coffee = spawn cmd, options
    coffee.stdout.pipe process.stdout
    coffee.stderr.pipe process.stderr
    log 'Watching coffee files in /src ...'


    #
    # watch app and views dir for changes
    # and respawn server on change
    # 
    # ...(um).. i think that's what its doing...

    supervisor = spawn 'node', [
        './node_modules/supervisor/lib/cli-wrapper.js',
        '-w','app,views', 
        '-e', 'js|jade', 
        'server'
    ]
    supervisor.stdout.pipe process.stdout
    supervisor.stderr.pipe process.stderr
    log 'Watching /app and /views, spawning server ...'


task 'build', 'Build a release.', -> 
    build -> log "build ok"
