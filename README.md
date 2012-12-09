gimbal
======

a game

### and an exercise toward learning:

* [node.js](http://nodejs.org/)
* [express.js](http://expressjs.com/)
* [socket.io](http://socket.io/)
* [angular.js](http://angularjs.org/)
* [three.js](https://github.com/mrdoob/three.js.git)

### also

* [pointerlock api](http://www.html5rocks.com/en/tutorials/pointerlock/intro/)
* [working example](https://plus.google.com/113862800338869870683/posts/L3uVi8w6pie)

### thanks

* portions of the base scaffold where tailored from [this template](https://github.com/twilson63/express-coffee) 

### dev mode

* assumes node.js installed
* assumes cake is in $PATH 
* assumes [foreman](https://github.com/ddollar/foreman) in installed

<pre>

    $ npm install

    #
    # and, while 'et' is being developed inline
    # 
    cd node_modules
    git clone git@github.com:nomilous/et.git
    git checkout develop


    # 
    # starts redis and mongo
    # 
    $ foreman start --procfile=Procfile.support

    #
    # starts app (another terminal)
    #
    $ cake dev

</pre>

