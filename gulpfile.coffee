gulp         = require 'gulp'
sass         = require 'gulp-sass'
sourcemaps   = require 'gulp-sourcemaps'
postcss      = require 'gulp-postcss'
autoprefixer = require 'autoprefixer'
minifyCSS    = require 'gulp-minify-css'
rename       = require 'gulp-rename'
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
  build_scss: [
    './src/scss/modules/_vars.scss'
    './src/scss/modules/_mixins.scss'
    './src/scss/modules/_build_container.scss'
    './src/scss/modules/_build_rows.scss'
    './src/scss/modules/_build_grids.scss'
    './src/scss/modules/_grid_states.scss'
  ]
  dist_file: '_flex_e_ble.scss'
  jade: './src/tmpl/*.jade'
}

gulp.task 'styles', ->
  gulp.src _paths.scss
  .pipe sass().on('error', sass.logError)
  .pipe postcss _processors
  .pipe sourcemaps.write()
  .pipe gulp.dest _paths.build

gulp.task 'minify', ->
  gulp.src _paths.build + '/*.css'
  .pipe minifyCSS
    keepBreaks: false
    aggressiveMerging: false
    roundingPrecision: -1
  .pipe rename
    suffix: '.min'
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
  .pipe gulp.dest _paths.build


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
  runSequence ['clean'], ['styles', 'jade'], ['merge'], ['minify']
