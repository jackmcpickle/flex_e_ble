gulp         = require 'gulp'
sass         = require 'gulp-sass'
sourcemaps   = require 'gulp-sourcemaps'
postcss      = require 'gulp-postcss'
autoprefixer = require 'autoprefixer'
cssnano      = require 'gulp-cssnano'
rename       = require 'gulp-rename'
runSequence  = require 'run-sequence'
concat       = require 'gulp-concat'
clean        = require 'gulp-clean'
watch        = require 'gulp-watch'
jade         = require 'gulp-jade'
sassLint     = require 'gulp-sass-lint'
gutil        = require 'gulp-util'

_browsers = [ '> 5%', 'last 3 versions' ]

_processors = [
  autoprefixer( browsers: _browsers )
]

_jadeLocals = {
  pageTitle: 'flex _ e _ ble'
}

_paths = {
  scss       : './src/scss/**/*.scss'
  build      : './dist'
  build_css  : './dist/css'
  build_scss : [
    './src/scss/modules/_vars.scss'
    './src/scss/modules/_mixins.scss'
    './src/scss/modules/_build_container.scss'
    './src/scss/modules/_build_rows.scss'
    './src/scss/modules/_build_grids.scss'
    './src/scss/modules/_grid_states.scss'
    './src/scss/modules/_vars.scss'
  ]
  dist_file  : '_flex_e_ble.scss'
  jade       : './src/tmpl/*.jade'
  build_docs : './dist/docs'
  built_css  : ['./dist/css/*.css', '!./dist/css/*.min.css']
}

gulp.task 'sass', ->
  gulp.src _paths.scss
  .pipe sass
    includePaths: 'node_modules'
    outputStyle: 'expanded'
  .on('error', sass.logError)
  .pipe postcss _processors
  .pipe sourcemaps.write()

  .pipe gulp.dest _paths.build_css


gulp.task 'minify', ->
  gulp.src _paths.built_css
  .pipe cssnano safe: true
  .pipe rename
    suffix: '.min'
  .pipe gulp.dest _paths.build_docs


gulp.task 'merge', ->
  gulp.src _paths.build_scss
    .pipe concat _paths.dist_file
    .pipe gulp.dest _paths.build


gulp.task 'jade', ->
  gulp.src _paths.jade
  .pipe jade
    locals: _jadeLocals
    pretty: true
  .pipe gulp.dest _paths.build_docs


gulp.task 'sassLint', ['sass'], ->
  gulp.src(_paths.scss)
  .pipe sassLint()
  .pipe sassLint.format()
  .pipe sassLint.failOnError()


gulp.task 'clean', ->
  gulp.src _paths.build, read: false
  .pipe clean()


gulp.task 'watch', (cb) ->
  watch _paths.scss, ->
    gulp.start 'sassLint'

  watch _paths.jade, ->
    gulp.start 'jade'


gulp.task 'build', ['jade', 'sass', 'merge']

gulp.task 'watch', ->
  runSequence 'build', 'watch'

gulp.task 'lint', ['sassLint']

gulp.task 'default', ->
  runSequence ['clean'], ['build'], ['merge'], ['minify']
