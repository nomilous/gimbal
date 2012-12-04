namespace 'gimbal'

    Application : angular

        .module( 'gimbal', ['ui'] )

        .directive( 'gimbalSession', gimbal.SessionDirective )

ready = true
