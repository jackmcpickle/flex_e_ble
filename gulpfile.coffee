gulp         = require 'gulp'
sass         = require 'gulp-sass'
sourcemaps   = require 'gulp-sourcemaps'
postcss      = require 'gulp-postcss'
autoprefixer = require 'autoprefixer'
minifyCSS    = require 'gulp-minify-css'
runSequence  = require 'run-sequence'
concat       = require 'gulp-concat'
clean        = require 'gulp-clean'
watch        = require 'gulp-watch'
jade         = require 'gulp-jade'

_browsers = [ '> 2%', 'last 3 versions' ]

_processors = [
  autoprefixer( browsers: _browsers )
]

_jadeLocals = {
  pageTitle: 'flex _ e _ ble'
}

_paths = {
  scss: './src/scss/**/*.scss'
  build: './dist'
  build_scss: './src/scss/modules/*.scss'
  dist_file: '_flex_e_ble.scss'
  jade: './src/docs/*.jade'
  docs: './docs'
}

gulp.task 'styles', ->
  gulp.src _paths.scss
  .pipe sass().on('error', sass.logError)
  .pipe postcss _processors
  .pipe sourcemaps.write()
  .pipe gulp.dest _paths.build

gulp.task 'minify', [ 'styles' ], ->
  gulp.src _paths.build + '/*.css'
  .pipe sourcemaps.init()
  .pipe minifyCSS
    keepBreaks: false
    aggressiveMerging: false
    roundingPrecision: -1
  .pipe sourcemaps.write './.'
  .pipe gulp.dest _paths.build

gulp.task 'merge', ->
  gulp.src _paths.build_scss
    .pipe concat _paths.dist_file
    .pipe gulp.dest _paths.build

gulp.task 'jade', ->
  gulp.src _paths.jade
  .pipe jade
    locals: _jadeLocals
    pretty: true
  .pipe gulp.dest _paths.docs


gulp.task 'clean', ->
  gulp.src _paths.build, read: false
  .pipe clean()

gulp.task 'watch', (cb) ->
  watch _paths.scss, ->
    gulp.start 'styles'

  watch _paths.jade, ->
    gulp.start 'jade'

gulp.task 'default', ['jade', 'styles', 'watch']

gulp.task 'build', ->
  runSequence ['clean'], ['styles'], ['merge'], ['minify']
