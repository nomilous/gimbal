// Generated by CoffeeScript 1.6.3
var define;

if (typeof define !== 'function') {
  define = require('amdefine')(module);
}

define(function() {
  return function(AsJustInTime, AsState) {
    return function(token) {
      if (!((token.pair != null) && (token.pair.intersect != null))) {
        AsJustInTime.call(token, 'intersect', function(token, a, b, state) {
          var intersect, range, range_state;
          if (state == null) {
            state = {};
            AsState.call(state, 'intersect');
            AsState.call(state, 'inside');
            state.lighter = null;
            state.closing = null;
          }
          state.lighter = a.mass < b.mass ? a : b;
          range_state = token.pair.range_scalar(token, token.cycle, a, b);
          state.closing = range_state.range.delta;
          range = range_state.range.get;
          intersect = a.radius + b.radius > range;
          if (!intersect) {
            state.intersect.set(intersect);
            state.inside.set(false);
            return state;
          }
          state.inside.set(a.radius < b.radius ? a.radius > range : a.radius > range);
          state.intersect.set(state.inside.get ? Math.abs(a.radius - b.radius) < range : intersect);
          return state;
        });
      }
      return this.detectCollision = function(token, actor1, actor2) {
        return token.pair.intersect(token, token.cycle, actor1, actor2);
      };
    };
  };
});