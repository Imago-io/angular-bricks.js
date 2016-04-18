angular.module('angular-bricksjs', [])
  .directive 'imagoBricksjs', ($timeout) ->

    {
      scope:
        items: '=source'
        sizes: '='
        packed: '@'

      link: (scope, element, attrs) ->

        randomString = (length) ->
          chars = 'abcdefghiklmnopqrstuvwxyz'.split('')
          if !length
            length = Math.floor(Math.random() * chars.length)
          str = ''
          i = 0
          while i < length
            str += chars[Math.floor(Math.random() * chars.length)]
            i++
          str

        uuid = randomString()
        element.attr('id', uuid)
        scope.packed or= 'data-packed'

        scope.init = ->
          scope.started = true
          scope.instance = Bricks
            sizes: scope.sizes
            container: '#' + uuid
            packed: scope.packed
          scope.instance.resize(true).pack()

        scope.update = ->
          scope.instance.update()

        scope.$watchGroup ['items', 'sizes'], (value) ->
          for item in value
            return unless item?.length
          if !scope.started and value.length
            scope.init()
          else if scope.started
            scope.update()

    }