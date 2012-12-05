namespace 'gimbal'
    
    SessionService : class SessionService

        @$inject : ['$log', '$cookies', '$http']

        constructor : (log, @cookies, http) ->

            log.info 'init gimbal.SessionService with cookies'

            http.post '/login'

                username : 'test'
                password : 'ing'

            return this
