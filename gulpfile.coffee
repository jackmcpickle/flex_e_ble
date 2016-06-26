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
csslint      = require 'gulp-csslint'
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
  build_scss : './src/scss/modules/*.*'
  dist_file  : '_flex_e_ble.scss'
  jade       : './src/tmpl/*.jade'
  build_docs : './dist/docs'
  built_css  : ['./dist/css/*.css', '!./dist/*.min.css']
}

customReporter = (file) ->
  errorCount = gutil.colors.cyan(file.csslint.errorCount)
  errorPath  = gutil.colors.magenta(file.path)
  gutil.log(errorCount+' errors in '+errorPath)

  file.csslint.results.forEach (result) ->
    gutil.log(result.error.message+' on line '+result.error.line)
    throw result.error.message if result.error.type is 'error'

gulp.task 'styles', ->
  gulp.src _paths.scss
  .pipe sass
    includePaths: 'node_modules'
    outputStyle: 'expanded'
  .on('error', sass.logError)
  .pipe postcss _processors
  .pipe sourcemaps.write()
  .pipe gulp.dest _paths.build_css

gulp.task 'minify', ->
  gulp.src _paths.build + '/*.css'
  .pipe cssnano safe: true
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
  .pipe gulp.dest _paths.build_docs

gulp.task 'csslint', ->
  gulp.src(_paths.built_css)
  .pipe csslint()
  .pipe csslint.reporter(customReporter)
  # .pipe csslint.failReporter()

gulp.task 'sassLint', ['styles'], ->
  gulp.src(_paths.scss)
  .pipe sassLint()
  .pipe sassLint.format()

gulp.task 'clean', ->
  gulp.src _paths.build, read: false
  .pipe clean()

gulp.task 'watch', (cb) ->
  watch _paths.scss, ->
    gulp.start 'sassLint'

  watch _paths.jade, ->
    gulp.start 'jade'

gulp.task 'default', ['jade', 'sassLint', 'watch']

gulp.task 'lint', ['sassLint', 'csslint']

gulp.task 'build', ->
  runSequence ['clean'], ['sassLint', 'jade'], ['merge'], ['minify']
