namespace 'gimbal'

    ViewportDirective : class ViewportDirective

        @$inject : ['$log', '$resource']

        constructor : (log, resource) -> 

            log.info 'init ViewportDirective'

            linkFn = (scope, element, attributes) -> 

                Actors = resource 'actors/:id', { id: '@_id' }

                scope.actorData = Actors.get

                    id : '123456fedcba65432100001'


            return {

                restrict : 'E',
                link : linkFn,
                template : """

                    <div class="viewport">

                        {{ actorData }}

                    </div>


                           """

            }
