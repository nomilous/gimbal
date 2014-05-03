if typeof define isnt 'function' then define = require('amdefine')(module)

define [

    './boundary_sphere.js',
    './spherical_mass.js'


], (

    BoundarySphere,
    SphericalMass

) -> 

    BoundarySphere: BoundarySphere
    SphericalMass: SphericalMass
