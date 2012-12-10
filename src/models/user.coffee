class User

    @get : (id) ->

    @validate : (username, password) -> 

        #
        # return fake authenticated user
        #

        username: username
        id: 1

module.exports = User
