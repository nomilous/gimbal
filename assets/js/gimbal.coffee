namespace 'gimbal'

    Application : angular

        .module( 'gimbal', ['ui', 'ngCookies', 'ngResource'] )

        .directive( 'gimbalSession', gimbal.SessionDirective )

        .factory( 'sessionService', gimbal.SessionService )

        .directive( 'gimbalViewport', gimbal.ViewportDirective )

ready = true
