import gulp         from 'gulp';
import sass         from 'gulp-sass';
import concat       from 'gulp-concat';
import pug          from 'gulp-pug';
import sassLint     from 'gulp-sass-lint';
import del from 'del';

import { version } from './package.json';

const _jadeLocals = {
  pageTitle: 'flex _ e _ ble',
  version
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


export const styles = () =>
  gulp.src( _paths.scss )
  .pipe( sass({ includePaths: 'node_modules', outputStyle: 'expanded' })
  .on('error', sass.logError))
  .pipe( gulp.dest( _paths.build_css ))


export const merge = () =>
  gulp.src( _paths.build_scss )
    .pipe( concat( _paths.dist_file ) )
    .pipe( gulp.dest( _paths.build ) )

export const jade = () =>
  gulp.src( _paths.jade )
  .pipe( pug({ locals: _jadeLocals, pretty: true }) )
  .pipe( gulp.dest( _paths.build_docs ) )

export const lintStyles = () =>
  gulp.src( _paths.scss )
  .pipe( sassLint() )
  .pipe( sassLint.format() )
  .pipe( sassLint.failOnError() )


export const clean = () => del([_paths.build]);
export const buildStyles = gulp.parallel(lintStyles, styles);

export function watch() {
  gulp.watch( _paths.scss, buildStyles );
  gulp.watch( _paths.jade, jade );
}


export const build = gulp.series(clean, gulp.parallel(jade, buildStyles, merge));

export default gulp.series(build, watch);
