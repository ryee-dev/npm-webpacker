(work-in-progress)

# npm-webpack installer

Originally, I was hoping to be able to have this script be able to create and update all necessary files and folders, but ran into a few roadblocks.

For now, this script will install all the important and relevant plugins, scripts, and dependencies necessary so far.

These include:

- create package.json
- dependency: webpack development dependency
- dependency: allow webpack use from command line (CLI - command line interface)
- dependency: allows images to be retrieved from the 'src/img' folder
- dependency: jquery
- dependency: popper
- dependency: bootstrap
- dependency: styles.css
- dependency (plugin): webpack plugin
- dependency (plugin): webpack declutterer
- dependency (plugin): uglify
- dependency (plugin): webpack development server
- dependency (linter): eslint
- dependenct (linter): eslint loader

### Jasmine

- jasmine node module
- jasmine helper package
- initialize jasmine

### Karma

- karma test-runner
- integrate jasmine and karma
- specify chrome browser
- karma cli
- karma webpack integration
- karma jquery integration
- karma testing reporter
- initialize karma

### Babel

- babel loader

# MANUALLY UPDATE PACKAGE.JSON

### replace
```
...
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
...
```
### with
```
...
  "scripts": {
    "build": "webpack --mode development",
    "start": "webpack-dev-server --open --mode development",
    "lint": "eslint src/*.js",
    "test": "karma start karma.conf.js",
    "test": "jasmine"
  },
...
```

## Instructions

**Clone**
```
$ cd Desktop
$ git clone https://github.com/ryee926/npm-webpacker
```


**Run Script**
```
$ cd npm-webpacker/
$ ruby launch.rb
```

## Changelog

#### v.1.0.4
- adds plugin to enable access to 'src/img' folder (*credit to: @wh0pper, great find :D*)
- some refactoring

#### v. 1.0.1
- fixes webpack.config.js syntax errors (*credit to: @logmannn, thanks!*)
- still unable to update script portion of .json

#### v. 1.0.0
- currently unable to update the script portion of package.json
- does not fully update the webpack.config.js file
- these must be manually updated.

## Contact
If you have any questions or anything lmk.

Goodnight!
