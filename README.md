# npm-webpack installer

This script will create all necessary initial files and folders & will install all the important and relevant plugins, scripts, and dependencies necessary.

# Instructions

## 1. **Clone**
```
$ cd desktop
$ git clone https://github.com/ryee926/npm-webpacker
```

## 2. **Run Script**
```
$ cd npm-webpacker
$ ruby launch.rb
```

## 3. *IMPORTANT* | **Update package.json** | *IMPORTANT*
```
$ cd (your project folder)
$ atom .
```
#### *(ctrl-f) || (⌘-f)*
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
  "start": "webpack --mode development; webpack-dev-server --open --mode development",
  "lint": "eslint --fix src/*.js",
  "test": "karma start karma.conf.js --mode development"
},
```

## 4. **PREP FOR BUILD/START**
```
$ npm install
```

## 5. **SUCCESS**
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


- [x] creates package.json
- [x] dependency: installs most recent version of npm
- [x] dependency: webpack development dependency
- [x] dependency: allow webpack use from command line (CLI - command line interface)
- [x] dependency: allows images to be retrieved from the 'src/img' folder
- [x] dependency: jquery
- [x] dependency: popper
- [x] dependency: bootstrap
- [x] dependency: styles.css
- [x] dependency (plugin): webpack plugin
- [x] dependency (plugin): webpack declutterer
- [x] dependency (plugin): uglify
- [x] dependency (plugin): webpack development server
- [x] dependency (linter): eslint
- [x] dependenct (linter): eslint loader
* Jasmine
- [x] jasmine node module
- [x] jasmine helper package
- [x] initialize jasmine
* Karma
- [x] karma test-runner
- [x] integrate jasmine and karma
- [x] specify chrome browser
- [x] karma cli
- [x] karma webpack integration
- [x] karma jquery integration
- [x] karma testing reporter
- [x] initialize karma
* Babel
- [x] babel loader

## Changelog

#### v.1.0.6
* Adds a spec template within the spec folder created through
```
$ karma init
```

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

ryee926@gmail.com or msg on slack
