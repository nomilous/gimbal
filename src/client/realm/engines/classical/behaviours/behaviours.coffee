if typeof define isnt 'function' then define = require('amdefine')(module)

define [

    './existance.js'
    './motion.js'
    './gravitation.js'
    './collision.js'

], (Existance, Motion, Gravitation, Collision) -> 

    Existance: Existance
    Motion: Motion
    Gravitation: Gravitation
    Collision: Collision
