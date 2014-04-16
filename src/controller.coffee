
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
    fov      = 45
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


    radius          = 5 #0
    segments        = 16
    rings           = 16
    sphereGeometry  = new THREE.SphereGeometry radius, segments, rings
    sphereMaterial  = new THREE.MeshLambertMaterial color: 0xFFFFFF
    sphere1         = new THREE.Mesh sphereGeometry, sphereMaterial
    sphere2         = new THREE.Mesh sphereGeometry, sphereMaterial
    scene.add sphere1
    scene.add sphere2


    pointLight = new THREE.PointLight 0xFFFFFF
    pointLight.position.x = 10
    pointLight.position.y = 50
    pointLight.position.z = 130
    scene.add pointLight

    x = 0

    animate = ->

        try
            requestAnimationFrame animate
            sphere1.position.x = 100
            sphere2.position.x = -100
            renderer.render scene, camera

    animate()