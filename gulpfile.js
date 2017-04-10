const fs           = require('fs');
const gulp         = require('gulp');
const sass         = require('gulp-sass');
const postcss      = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const sassdoc      = require('sassdoc');
const runSequence  = require('run-sequence');
const concat       = require('gulp-concat');
const clean        = require('gulp-clean');
const watch        = require('gulp-watch');
const pug          = require('gulp-pug');
const sassLint     = require('gulp-sass-lint');
const npmVersion   = JSON.parse(fs.readFileSync('./package.json')).version;
const _browsers = [ '> 5%', 'last 3 versions' ];

const _processors = [
  autoprefixer({ browsers: _browsers })
];

const _jadeLocals = {
  pageTitle: 'flex _ e _ ble',
  version: npmVersion
};

const _paths = {
  scss       : './src/scss/**/*.scss',
  build      : './dist',
  build_css  : './dist/css',
  build_scss : [
    './src/scss/modules/_vars.scss',
    './src/scss/modules/_functions.scss',
    './src/scss/modules/_mixins.scss',
    './src/scss/modules/_build_container.scss',
    './src/scss/modules/_build_rows.scss',
    './src/scss/modules/_build_grids.scss',
    './src/scss/modules/_grid_states.scss',
    './src/scss/modules/_vars.scss'
  ],
  dist_file  : '_flex_e_ble.scss',
  jade       : './src/tmpl/*.jade',
  build_docs : './dist/docs',
  built_css  : ['./dist/css/*.css', '!./dist/css/*.min.css']
};


const sassDocOptions = {
  dest: _paths.build_docs,
  verbose: true,
  display: {
    access: ['public', 'private'],
    alias: true,
    watermark: true,
  },
  // theme: 'neat',
  basePath: 'https://github.com/jackmcpickle/flex_e_ble/tree/master/dist',
};




gulp.task( 'sass', () =>
  gulp.src( _paths.scss )
  .pipe( sass({ includePaths: 'node_modules', outputStyle: 'expanded' })
  .on('error', sass.logError))
  .pipe( postcss( _processors ) )
  .pipe( gulp.dest( _paths.build_css ))
);

gulp.task( 'sassMerge', ['sass'], () =>
  gulp.src( _paths.build_scss )
    .pipe( concat( _paths.dist_file ) )
    .pipe( gulp.dest( _paths.build ) )
);

gulp.task( 'jade', () =>
  gulp.src( _paths.jade )
  .pipe( pug({ locals: _jadeLocals, pretty: true }) )
  .pipe( gulp.dest( _paths.build_docs ) )
);

gulp.task( 'sassdoc', ['sassMerge'], () =>
  gulp.src(`${_paths.build}/*.scss`)
  .pipe(sassdoc(sassDocOptions))
);

gulp.task( 'sassLint', ['sassMerge'], () =>
  gulp.src( _paths.scss )
  .pipe( sassLint() )
  .pipe( sassLint.format() )
  .pipe( sassLint.failOnError() )
);

gulp.task( 'clean', () =>
  gulp.src( _paths.build, { read: false } )
  .pipe( clean() )
);

gulp.task( 'watch', (cb) => {
  watch( _paths.scss, () => gulp.start( 'sassdoc' ) );
  watch( _paths.jade, () => gulp.start( 'jade' ) );
  cb();
});

gulp.task( 'build', (cb) => runSequence('clean', ['jade', 'sass', 'sassMerge'], ['sassdoc'], cb) );

gulp.task( 'lint', ['sassLint']);

gulp.task( 'default', (cb) => runSequence( 'build', 'watch', cb) );
