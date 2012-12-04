namespace 'gimbal'
    
    SessionService : class SessionService

        @$inject : ['$log', '$cookies']

        constructor : (log, @cookies) ->

            log.info 'init gimbal.SessionService with cookies'

            return this
