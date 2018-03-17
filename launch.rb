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
    FileUtils.mkdir('src/img')
    FileUtils.touch('src/index.html')
    FileUtils.touch('src/styles.css')
    FileUtils.touch('src/main.js')
    FileUtils.touch("src/#{@project_name}.js")
    FileUtils.touch('webpack.config.js')
    FileUtils.touch('.gitignore')
    FileUtils.touch('.eslintrc')

    ### terminal commands

    if @install_all

      # npm essentials
        # create package.json
          system 'npm init -y'
        # dependency: installs most recent version of npm
          system 'npm install npm@latest -g'
        # dependency: webpack development dependency
          system 'npm install webpack@4.0.1 --save-dev'
        # dependency: allow webpack use from command line (CLI - command line interface)
          system 'npm install webpack-cli@2.0.9 --save-dev'
        # dependency: allows images to be retrieved from the img folder
          system 'npm install --save-dev copy-webpack-plugin'
      # JS libraries
        # dependency: jquery.js
          system 'npm install jquery --save'
        # dependency: popper.js
          system 'npm install popper.js --save'
        # dependency: tailwind
          system 'npm install tailwindcss --save-dev'
          system 'tailwind init'
      # CSS libraries
        # dependency: bootstrap.css
          system 'npm install bootstrap --save'
        # dependency: animate.css
          system 'npm install animate.css --save'
        # dependency: images folder
          system 'npm install url-loader file-loader --save-dev'
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
        # dependency (linter): eslint loader
          system 'npm install eslint-loader@2.0.0 --save-dev'

      ## jasmine installation
        # jasmine node module
        system 'npm install jasmine-core@2.99.0 --save-dev'
        # jasmine helper package
        system 'npm install jasmine@3.1.0 --save-dev'
        # initialize jasmine
        system './node_modules/.bin/jasmine init'

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

      ## babel installation
        # core
        system 'npm install babel-core@6.26.0 babel-loader@7.1.3 babel-preset-es2015@6.24.1 --save-dev'


    # add spec file to newly created spec folder
    FileUtils.touch("spec/#{@project_name}-spec.js")

    # populate spec file with basic template
    File.open("spec/#{@project_name}-spec.js", 'w') { |file|
      file.write(
        "// import { Constructor } from './../src/#{@project_name}.js'\n\ndescribe('', function() {\n\n  it('', function() {\n    // var example = new Constructor(parameters)\n    // expect(example.method()).toEqual('');\n  });\n});"
      )
    }

    File.open('.gitignore', 'w') { |file|
      file.write(
        "node_modules/\n.DS_Store\ndist/"
        ) }

# .eslintrc

    File.open('.eslintrc', 'w') { |file|
      file.write(
        "{\n  'parserOptions': {\n    'ecmaVersion': 6,\n    'sourceType': 'module'\n  },\n  'extends': 'eslint:recommended',\n  'env': {\n    'browser': true,\n    'jquery': true,\n    'node': true,\n    'jasmine': true\n  },\n  'rules': {\n    'semi': 1,\n    'indent': ['warn', 2],\n    'no-console': 'warn',\n    'no-debugger': 'warn',\n    'no-unused-vars': 'warn',\n    'no-mixed-spaces-and-tabs': 'warn'\n  }\n}"
        ) }

# index.html

    File.open('src/index.html', 'w') { |file|
      file.write(
        "<!DOCTYPE html>\n<html>\n  <head>\n    <title>#{@project_title}</title>\n  </head>\n  <body>\n    <div class='container'>\n      <h1>#{@project_title}</h1>\n    </div>\n  </body>\n</html>"
        ) }

# main.js

    File.open('src/main.js', 'w') { |file|
      file.write(
        "import './styles.css';\nimport $ from 'jquery';\nimport 'bootstrap/dist/css/bootstrap.min.css';\n//import { **insert prototype name** } from './#{@project_name}.js';\n\n$(document).ready(function() {\n\n});"
        ) }

# webpack.config.js

    File.open('webpack.config.js', 'w') { |file|
      file.write(
        "const path = require('path');\nconst HtmlWebpackPlugin = require('html-webpack-plugin');\nconst CleanWebpackPlugin = require('clean-webpack-plugin');\nconst UglifyJsPlugin = require('uglifyjs-webpack-plugin');\nconst CopyWebpackPlugin = require('copy-webpack-plugin');\n\nmodule.exports = {\n  entry: './src/main.js',\n  output: {\n    filename: 'bundle.js',\n    path: path.resolve(__dirname, 'dist')\n  },\n  devtool: 'eval-source-map',\n  devServer: {\n    contentBase: './dist'\n  },\n  plugins: [\n    new CopyWebpackPlugin([\n      {from:'./src/img',to:'images'}\n    ]),\n    new UglifyJsPlugin({ sourceMap: true }),\n    new CleanWebpackPlugin(['dist']),\n    new HtmlWebpackPlugin({\n      title: '#{@project_title}',\n      template: './src/index.html',\n      inject: 'body'\n    })\n  ],\n  module: {\n    rules: [\n      {\n        test: /\\.css$/,\n        use: [\n          'style-loader',\n          'css-loader'\n        ]\n      },\n      {\n        test: /\\.(gif|png|jpe?g|svg)$/i, // image code\n        use: [\n          'file-loader',\n          {\n            loader: 'image-webpack-loader', // image code\n            options: {\n              bypassOnDebug: true,\n            },\n          },\n        ],\n      },\n      {\n        test: /\\.js$/,\n        exclude:[\n          /node_modules/,\n          /spec/\n        ],\n        loader: 'eslint-loader'\n      },\n      {\n        test: /\\.js$/,\n        exclude: [\n          /node_modules/,\n          /spec/\n        ],\n        loader:'babel-loader',\n        options: {\n          presets: ['es2015']\n        }\n      }\n    ]\n  }\n};"
      )
    }

# karma.conf.js

    File.open('karma.conf.js', 'w') { |file|
      file.write(
        "const webpackConfig = require('./webpack.config.js');\nmodule.exports = function(config) {\n  config.set({\n    basePath: '',\n    frameworks: ['jquery-3.2.1', 'jasmine'],\n    files: [\n      'src/*.js',\n      'spec/*spec.js'\n    ],\n    webpack: webpackConfig,\n    exclude: [\n    ],\n    preprocessors: {\n      'src/*.js': ['webpack'],\n      'spec/*spec.js': ['webpack']\n    },\n    plugins: [\n      'karma-jquery',\n      'karma-webpack',\n      'karma-jasmine',\n      'karma-chrome-launcher',\n      'karma-jasmine-html-reporter'\n    ],\n    reporters: ['progress', 'kjhtml'],\n    port: 9876,\n    colors: true,\n    logLevel: config.LOG_INFO,\n    autoWatch: true,\n    browsers: ['Chrome'],\n    singleRun: false,\n    concurrency: Infinity\n  })\n}"
      )
    }

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
