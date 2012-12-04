namespace 'gimbal'

    SessionDirective : class SessionDirective

        @$inject : ['$log', 'sessionService']

        constructor : (log, session) -> 

            log.info 'init gimbal.SessionDirective'

            linkFn = (scope, element, attributes) -> 

                scope.cookies = session.cookies

            return {

                restrict : 'E',
                link : linkFn,
                templateUrl : '/templates/session'

            }
