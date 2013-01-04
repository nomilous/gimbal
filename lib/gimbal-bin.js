// Generated by CoffeeScript 1.4.0
var et, gimbal, plex;

plex = require('plex');

et = require('et');

gimbal = require('./gimbal');

module.exports = function(port) {
  var context;
  if (port == null) {
    port = 3000;
  }
  context = plex.start({
    mode: 'proxy',
    connect: {
      adaptor: 'socket.io',
      uri: 'http://localhost:3332'
    },
    listen: {
      adaptor: 'socket.io',
      server: et.al({
        port: port
      })
    }
  });
  context.listen.server.get('/', function(req, res) {
    return res.send('');
  });
  return context.listen.server;
};