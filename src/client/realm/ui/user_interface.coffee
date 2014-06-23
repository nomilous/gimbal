if typeof define isnt 'function' then define = require('amdefine')(module)

define -> 

    class UserInterface

        constructor: (globals, config) ->

            globals.app.controller 'UI', ($scope) ->

                $scope.restart = ->

                    globals.realm.clear()
                    globals.init()

        registerActor: (actor) ->

