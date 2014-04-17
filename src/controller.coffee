
module.exports = controller = (opts, callback) -> 

    callback null, 

        headers: 'Content-Type': 'text/javascript'
        body: "(#{
            module.exports.client.toString()
        }).call(self);"

controller.$www = {}

module.exports.client = -> 

    dom   = require 'component~dom@1.0.5'
    THREE = require 'cvdlab~three@0.60.0'


    container = dom('body').append '<div></div>'

    #
    # http://www.aerotwist.com/tutorials/getting-started-with-three-js/
    # 

    width    = 400
    height   = 300
    fov      = 90
    aspect   = width / height
    near     = 0.1
    far      = 1000
    renderer = new THREE.WebGLRenderer
    camera   = new THREE.PerspectiveCamera fov, aspect, near, far
    scene    = new THREE.Scene

    scene.add camera
    camera.position.z = 300
    renderer.setSize width, height
    renderer.setClearColor 0x222222, 1
    
    container.append renderer.domElement

    radius1         = 10
    radius2         = 5
    segments        = 16
    rings           = 16
    sphere1Geometry  = new THREE.SphereGeometry radius1, segments, rings
    sphere2Geometry  = new THREE.SphereGeometry radius2, segments, rings
    sphereMaterial  = new THREE.MeshLambertMaterial color: 0xFFFFFF

    spheres = [
        new THREE.Mesh sphere1Geometry, sphereMaterial
        new THREE.Mesh sphere2Geometry, sphereMaterial
    ]

    scene.add spheres[0]
    scene.add spheres[1]

    pointLight = new THREE.PointLight 0xFFFFFF
    pointLight.position.x = 10
    pointLight.position.y = 50
    pointLight.position.z = 130
    scene.add pointLight


    t = 5
    spheres[0].velocity = [ 0.0,  0.2, 0.0 ]
    spheres[1].velocity = [ 0.0, -2.0, 0.0 ]
    spheres[0].acceleration = new THREE.Vector3
    spheres[1].acceleration = new THREE.Vector3
    spheres[0].mass = 1000.0
    spheres[1].mass = 100.0
    spheres[0].position.x = 0.1
    spheres[1].position.x = -200


    animate = ->

        try
            requestAnimationFrame animate

            position1       = spheres[0].position
            position2       = spheres[1].position
            distanceScalar  = Math.sqrt Math.abs position1.dot position2
            massSum         = spheres[0].mass + spheres[1].mass
            G               = 0.01

            forceScalar     = ( G * massSum ) / distanceScalar * distanceScalar
            forceVector     = new THREE.Vector3
            forceVector.subVectors position1, position2
            forceVector.normalize().multiplyScalar forceScalar

            spheres[0].acceleration.set -forceVector.x, -forceVector.y, -forceVector.z
            spheres[1].acceleration.set  forceVector.x,  forceVector.y,  forceVector.z

            
            for i in [0..1]

                spheres[i].acceleration.divideScalar spheres[i].mass

                spheres[i].velocity[0] += spheres[i].acceleration.x * t
                spheres[i].velocity[1] += spheres[i].acceleration.y * t
                spheres[i].velocity[2] += spheres[i].acceleration.z * t

                spheres[i].position.x += spheres[i].velocity[0] * t
                spheres[i].position.y += spheres[i].velocity[1] * t
                spheres[i].position.z += spheres[i].velocity[2] * t

            renderer.render scene, camera

    animate()
