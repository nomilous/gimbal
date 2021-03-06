// Generated by CoffeeScript 1.6.3
var define;

if (typeof define !== 'function') {
  define = require('amdefine')(module);
}

define(function() {
  return function(name) {
    return this[name] = {
      name: name,
      set: function(nextState) {
        if (this.get === null) {
          this.get = nextState;
          return this;
        }
        if (this.get === nextState) {
          this.changed = false;
          return this;
        }
        this.get = nextState;
        this.changed = true;
        return this;
      },
      get: null,
      changed: false
    };
  };
});
