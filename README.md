# npm-webpack installer
Originally, I was hoping to be able to have this script be able to create and update all necessary files and folders, but ran into a few roadblocks.

For now, this script will install all the important and relevant plugins, scripts, and dependencies necessary so far.

[X] creates package.json
[X] dependency: installs most recent version of npm
[X] dependency: webpack development dependency
[X] dependency: allow webpack use from command line (CLI [X] command line interface)
[X] dependency: allows images to be retrieved from the 'src/img' folder
[X] dependency: jquery
[X] dependency: popper
[X] dependency: bootstrap
[X] dependency: styles.css
[X] dependency (plugin): webpack plugin
[X] dependency (plugin): webpack declutterer
[X] dependency (plugin): uglify
[X] dependency (plugin): webpack development server
[X] dependency (linter): eslint
[X] dependenct (linter): eslint loader
### Jasmine
[X] jasmine node module
[X] jasmine helper package
[X] initialize jasmine
### Karma
[X] karma test[X]runner
[X] integrate jasmine and karma
[X] specify chrome browser
[X] karma cli
[X] karma webpack integration
[X] karma jquery integration
[X] karma testing reporter
[X] initialize karma
### Babel
[X] babel loader

# Instructions

1. **Clone**
```
$ cd Desktop
$ git clone https://github.com/ryee926/npm-webpacker
```

2. **Run Script**
```
$ npm-webpacker/ruby launch.rb
```

*## complete dependency installation ##*

3. **UPDATE PACKAGE.JSON**
#### *(ctrl-f)*
```
  "main": "webpack.config.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
```
#### *replace with*
```
  "main": "index.js",
  "scripts": {
    "build": "webpack --mode development",
    "start": "webpack-dev-server --open --mode development",
    "lint": "eslint src/*.js",
    "test": "karma start karma.conf.js",
  },
```

4. **PREP FOR BUILD/START**
```
$ npm install
```

5. **SUCCESS**
```
$ npm run build
```
*or*
```
$ npm run start
```
*or*
```
$ npm test
```

## Changelog

#### v.1.0.5
* ELI5-level README

#### v.1.0.4
* adds plugin to enable access to 'src/img' folder (*credit to: @wh0pper, great find :D*)
* some refactoring

#### v. 1.0.1
* fixes webpack.config.js syntax errors (*credit to: @logmannn, thanks!*)
* still unable to update script portion of .json

#### v. 1.0.0
* currently unable to update the script portion of package.json
* does not fully update the webpack.config.js file
* these must be manually updated.

## Contact
If you have any questions or anything lmk.

Goodnight!
