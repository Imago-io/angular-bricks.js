plugins         = require('gulp-load-plugins')()
gulp            = require 'gulp'

del             = require 'del'
notification    = require 'node-notifier'
vinylPaths      = require 'vinyl-paths'
browserSync     = require('browser-sync').create()

src = 'src'
dist = 'dist'

gulp.task 'clean', ->
  gulp.src("#{dist}/*.*", {read: false})
    .pipe(vinylPaths(del))

gulp.task 'coffee', ->
  gulp.src("#{src}/index.coffee")
    .pipe plugins.plumber(
      errorHandler: reportError
    )
    .pipe plugins.coffee().on('error', reportError)
    .pipe(plugins.concat('index.js'))
    .pipe(gulp.dest(dist))
    .pipe browserSync.reload(stream: true)

gulp.task 'watch', ['clean'], ->
  gulp.start 'coffee'

  browserSync.init
    server:
      baseDir: './example'
      routes:
        '/bower_components': 'bower_components'
        '/dist': 'dist'
    ghostMode: false

  gulp.watch "#{src}/*.coffee", ->
    gulp.start 'coffee'

  gulp.watch 'example/index.html', browserSync.reload

reportError = (err) ->
  plugins.util.beep()
  notification.notify
    title: "Error running Gulp"
    message: err.message
  plugins.util.log err.message
  @emit 'end'


gulp.task "default", ["watch"]

module.exports = gulp
