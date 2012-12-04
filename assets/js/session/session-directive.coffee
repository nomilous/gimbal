namespace 'gimbal'

    SessionDirective : class SessionDirective

        @$inject : ['$log']

        constructor : (log) -> 

            log.info 'init gimbal.SessionDirective'

            return {

                restrict : 'E',
                templateUrl : '/templates/session'

            }
