const pug = require('pug');
const fs = require('fs');

const { version } = require('./package.json');

const renderer = pug.compileFile('./src/tmpl/index.pug', {});
const output = renderer({ version });

fs.writeFile('./dist/docs/index.html', output, 'utf8', (err) => {
    console.log('Rendered')
})