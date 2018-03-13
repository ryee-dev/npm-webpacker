#!/usr/bin/ruby
require 'fileutils'

class String
  def titleize
    split(/(\W)/).map(&:capitalize).join
  end
end

class Project
  def initialize(project_name, project_title, install_all)
    @project_name = project_name
    @project_title = project_title
    @install_all = install_all
  end

  def create

  # directory & file creation

    FileUtils.cd '..'
    puts FileUtils.pwd
    FileUtils.mkdir(@project_name)
    FileUtils.cd "#{@project_name}"

    FileUtils.mkdir('dist')
    FileUtils.mkdir('src')
    FileUtils.touch('src/index.html')
    FileUtils.touch('src/main.js')
    FileUtils.touch("src/#{@project_name}.js")
    FileUtils.touch('webpack.config.js')
    FileUtils.touch('.gitignore')

    ### terminal commands

    if @install_all
      # create package.json
      system 'npm init -y'
      # dependency: webpack development dependency
      system 'npm install webpack@4.0.1 --save-dev'
      # dependency: allow webpack use from command line (CLI - command line interface)
      system 'npm install webpack-cli@2.0.9 --save-dev'
      # dependency: jquery
      system 'npm install jquery --save'
      # dependency: popper
      system 'npm install popper.js --save'
      # dependency: bootstrap
      system 'npm install bootstrap --save'
      # dependency: styles.css
      system 'npm install style-loader@0.20.2 css-loader@0.28.10 --save-dev'
      # dependency (plugin): webpack plugin
      system 'npm install html-webpack-plugin@3.0.6 --save-dev'
      # dependency (plugin): webpack declutterer
      system 'npm install clean-webpack-plugin@0.1.18 --save-dev'
      # dependency (plugin): uglify
      system 'npm install uglifyjs-webpack-plugin@1.2.2 --save-dev'
      # dependency (plugin): webpack development server
      system 'npm install webpack-dev-server@3.1.0 --save-dev'
      # dependency (linter): eslint
      system 'npm install eslint@4.18.2 --save-dev'
      # dependenct (linter): eslint loader
      system 'npm install eslint-loader@2.0.0 --save-dev'

      ## jasmine installation
        # jasmine node module
        system 'npm install jasmine-core@2.99.0 --save-dev'
        # jasmine helper package
        system 'npm install jasmine@3.1.0 --save-dev'
        # initialize jasmine
        system './node_modules/.bin/jasmine init'

        ## MUST MANUALLY UPDATE PACKAGE.JSON!
          # "scripts": {
          #   "test": "jasmine"
          # }

      ## karma installation
        # karma test-runner
        system 'npm install karma@2.0.0 --save-dev'
        # integrate jasmine and karma
        system 'npm install karma-jasmine@1.1.1 --save-dev'
        # specify chrome browser
        system 'npm install karma-chrome-launcher@2.2.0 --save-dev'
        # karma cli
        system 'npm install karma-cli@1.0.1 --save-dev'
        # karma webpack integration
        system 'npm install karma-webpack@2.0.13 --save-dev'
        # karma jquery integration
        system 'npm install karma-jquery@0.2.2 --save-dev'
        # karma testing reporter
        system 'npm install karma-jasmine-html-reporter@0.2.2 --save-dev'
        # initialize karma
        system 'karma init'

        # MANUALLY UPDATE PACKAGE.JSON
          # "scripts": {
          #   "test": "karma start karma.conf.js"
          #   },

        # MANUALLY UPDATE WEBPACK.CONFIG.JS
          #{
        #   test: /\.js$/,
        #   exclude: [
        #     /node_modules/,
        #     /spec/
        #   ],
        #   loader: "eslint-loader"
          # }

    # basic index template
    File.open('src/index.html', 'w') { |file|
      file.write(
        "<!DOCTYPE html>\n<html>\n  <head>\n    <title>#{@project_title}</title>\n  </head>\n  <body>\n    <h1>#{@project_title}</h1>\n  </body>\n</html>"
        ) }

    File.open('src/main.js', 'w') { |file|
      file.write(
        "import './styles.css';\nimport $ from 'jquery';\nimport 'bootstrap';\nimport 'bootstrap/dist/css/bootstrap.min.css';"
        ) }

    File.open('.gitignore', 'w') { |file|
      file.write(
        "node_modules/\n.DS_Store"
        ) }

    File.open('webpack.config.js', 'w') { |file|
      file.write(
        "const path = require('path');\nconst HtmlWebpackPlugin = require('html-webpack-plugin');\nconst CleanWebpackPlugin = require('clean-webpack-plugin');\nconst UglifyJsPlugin = require('uglifyjs-webpack-plugin');\n\nmodule.exports = {\n  entry: './src/main.js',\n  output: {\n    filename: 'bundle.js',\n    path: path.resolve(__dirname, 'dist')\n  },\n  devtool: 'eval-source-map',\n  devServer: {\n    contentBase: './dist'\n  },\n  plugins: [\n    new UglifyJsPlugin({ sourceMap: true }),\n    new CleanWebpackPlugin(['dist']),\n    new HtmlWebpackPlugin({\n      title: '#{@project_title}',\n      template: './src/index.html',\n      inject: 'body'\n    })\n  ],\n  module: {\n    rules: [\n      {\n        test: /\.js$/,\n        exclude: /node_modules/,\n        loader: 'eslint-loader'\n      },\n      {\n        test: /\.css$/,\n        use: [\n          'style-loader',\n          'css-loader'\n        ]\n      }\n    ]\n  }\n};"
        ) }

    File.open('karma.conf.js', 'w') { |file|
      file.write(
        "const webpackConfig = require('./webpack.config.js');\nmodule.exports = function(config) {\n  config.set({\n    basePath: '',\n    frameworks: ['jquery-3.2.1', 'jasmine'],\n    files: [\n      'src/*.js',\n      'spec/*spec.js'\n    ],\n    webpack: webpackConfig,\n    exclude: [\n  ],\n    preprocessors: {\n      'src/*.js': ['webpack'],\n      'spec/*spec.js': ['webpack']\n    },\n    plugins: [\n      'karma-jquery',\n      'karma-webpack',\n      'karma-jasmine',\n      'karma-chrome-launcher',\n      'karma-jasmine-html-reporter'\n    ],\n    reporters: ['progress', 'kjhtml'],\n    port: 9876,\n    colors: true,\n    logLevel: config.LOG_INFO,\n    autoWatch: true,\n    browsers: ['Chrome'],\n    singleRun:: false,\n    concurrency: Infinity\n  })\n}"
      )
    }

    # File.open(filename = "package.json", "r+") { |file| file << File.read(filename).gsub(/'test': 'echo \'Error: no test specified\' && exit 1'/, "'build': 'webpack --mode development',\n    'start': 'npm run build; webpack-dev-server --open'") }

    else
      puts 'Closing Script...'
    end
  end
end

puts 'Enter project name: '
project_name = gets.chomp

puts 'Enter project title: '
project_title = gets.chomp

puts 'Install ALL webpack dependencies? (y/n): '
response = gets.chomp
if response == 'y'
  install_all = true
else
  install_all = false
end

project = Project.new(project_name, project_title, install_all)
project.create
