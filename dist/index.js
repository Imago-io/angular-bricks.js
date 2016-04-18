(function() {
  angular.module('angular-bricksjs', []).directive('imagoBricksjs', function($timeout) {
    return {
      scope: {
        items: '=source',
        sizes: '=',
        packed: '@'
      },
      link: function(scope, element, attrs) {
        var randomString, uuid;
        randomString = function(length) {
          var chars, i, str;
          chars = 'abcdefghiklmnopqrstuvwxyz'.split('');
          if (!length) {
            length = Math.floor(Math.random() * chars.length);
          }
          str = '';
          i = 0;
          while (i < length) {
            str += chars[Math.floor(Math.random() * chars.length)];
            i++;
          }
          return str;
        };
        uuid = randomString();
        element.attr('id', uuid);
        scope.packed || (scope.packed = 'data-packed');
        scope.init = function() {
          scope.started = true;
          scope.instance = Bricks({
            sizes: scope.sizes,
            container: '#' + uuid,
            packed: scope.packed
          });
          return scope.instance.resize(true).pack();
        };
        scope.update = function() {
          return scope.instance.update();
        };
        return scope.$watchGroup(['items', 'sizes'], function(value) {
          var item, j, len;
          for (j = 0, len = value.length; j < len; j++) {
            item = value[j];
            if (!(item != null ? item.length : void 0)) {
              return;
            }
          }
          if (!scope.started && value.length) {
            return scope.init();
          } else if (scope.started) {
            return scope.update();
          }
        });
      }
    };
  });

}).call(this);
