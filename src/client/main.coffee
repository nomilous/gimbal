require [

    'three',

    'realm/ui/user_interface',
    'realm/visualizer/web_g_l_visualizer'

], (THREE, UserInterface, WebGLVisualizer) -> 
    

    ui = new UserInterface

    renderer = new WebGLVisualizer ui, 

        clearColor: 0x000000
        clearAlpha: 1
        fov:        120






# THREE     = require 'three'
# container = document.createElement 'div'
# document.body.appendChild container

# width    = 800
# height   = 600


# fov      = 90
# aspect   = width / height
# near     = 0.1
# far      = 1000
# history  = 1750
# renderer = new THREE.WebGLRenderer
# camera   = new THREE.PerspectiveCamera fov, aspect, near, far
# scene    = new THREE.Scene

# scene.add camera
# camera.position.z   = 300
# cameraRevolveAxis   = new THREE.Vector3 0.0, 1.0, 0.0
# cameraRevolveAngle  = 0.01
# cameraRevolveMatrix = new THREE.Matrix4().makeRotationAxis cameraRevolveAxis, cameraRevolveAngle


# renderer.setSize width, height
# renderer.setClearColor 0x222222, 1

# container.appendChild renderer.domElement

# radius1         = 5
# radius2         = 5
# segments        = 16
# rings           = 16







# sphere1Geometry  = new THREE.SphereGeometry radius1, segments, rings
# sphere2Geometry  = new THREE.SphereGeometry radius2, segments, rings
# sphereMaterial   = new THREE.MeshLambertMaterial color: 0xFFFFFF
# spheres = [
#     new THREE.Mesh sphere1Geometry, sphereMaterial
#     new THREE.Mesh sphere2Geometry, sphereMaterial
# ]
# scene.add spheres[0]
# scene.add spheres[1]



# # cubeGeometry = new THREE.CubeGeometry 1000, 1000, 1000
# # cubeMaterial = new THREE.MeshBasicMaterial color: 0xFFFFFF, wireframe: true
# # cube = new THREE.Mesh cubeGeometry, cubeMaterial
# # scene.add cube


# pointLight = new THREE.PointLight 0xFFFFFF
# pointLight.position.x = 10
# pointLight.position.y = 50
# pointLight.position.z = 130
# scene.add pointLight


# t = 5
# spheres[0].velocity = [ 0.0, -1.0, 0.0 ]
# spheres[1].velocity = [ 0.0,  1.0, 0.0 ]
# spheres[0].acceleration = new THREE.Vector3
# spheres[1].acceleration = new THREE.Vector3
# spheres[0].mass = 100.0
# spheres[1].mass = 100.0
# spheres[0].position.x = 200
# spheres[1].position.x = -200
# spheres[0].history    = []
# spheres[1].history    = []
# spheres[0].historyLine  = null
# spheres[1].historyLine  = null


# animate = ->

#     try
#         requestAnimationFrame animate

#         position1       = spheres[0].position
#         position2       = spheres[1].position
#         distanceScalar  = Math.sqrt Math.abs position1.dot position2
#         massSum         = spheres[0].mass + spheres[1].mass
#         G               = 0.01

#         forceScalar     = ( G * massSum ) / distanceScalar * distanceScalar
#         forceVector     = new THREE.Vector3
#         forceVector.subVectors position1, position2
#         forceVector.normalize().multiplyScalar forceScalar

#         spheres[0].acceleration.set -forceVector.x, -forceVector.y, -forceVector.z
#         spheres[1].acceleration.set  forceVector.x,  forceVector.y,  forceVector.z

        
#         for i in [0..1]

#             spheres[i].acceleration.divideScalar spheres[i].mass

#             spheres[i].velocity[0] += spheres[i].acceleration.x * t
#             spheres[i].velocity[1] += spheres[i].acceleration.y * t
#             spheres[i].velocity[2] += spheres[i].acceleration.z * t

#             spheres[i].position.x += spheres[i].velocity[0] * t
#             spheres[i].position.y += spheres[i].velocity[1] * t
#             spheres[i].position.z += spheres[i].velocity[2] * t

#             vertices = spheres[i].history
#             vertices.push spheres[i].position.clone()
#             vertices.shift() while vertices.length > history

#             # history1Geometry.verticesNeedUpdate = true
#             # history1Geometry.__dirtyVertices = true

#             scene.remove spheres[i].historyLine

#             historyMaterial    = new THREE.LineBasicMaterial color: 0x888888
#             historyGeometry    = new THREE.Geometry

#             try for j in [0..vertices.length - 1]
#                 # historyGeometry.vertices.push new THREE.Vector3 0,j*10,0
#                 historyGeometry.vertices.push spheres[i].history[j]

#             spheres[i].historyLine = new THREE.Line historyGeometry, historyMaterial
            
#             camera.position.applyMatrix4 cameraRevolveMatrix
#             camera.lookAt scene.position

#             scene.add spheres[i].historyLine
            

#         renderer.render scene, camera

# animate()