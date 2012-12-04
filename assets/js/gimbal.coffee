namespace 'gimbal'

    Application : angular

        .module( 'gimbal', ['ui', 'ngCookies'] )

        .directive( 'gimbalSession', gimbal.SessionDirective )

        .factory( 'sessionService', gimbal.SessionService )

ready = true
