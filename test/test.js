/* global __dirname */

const path     = require('path');
const sassTrue = require('sass-true');
const sassFile = path.join(__dirname, 'all.scss');

sassTrue.runSass(
  {
    file: sassFile,
    pathIncludes: ['.']
  },
  {
    sass: require('sass'),
    describe,
    it,
  }
);
