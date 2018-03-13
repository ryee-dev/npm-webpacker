#!/usr/bin/ruby
require 'fileutils'

class String
  def titleize
    split(/(\W)/).map(&:capitalize).join
  end
end

class Project
  def initialize(project_name, project_title, git_name, user_name)
    @project_name = project_name
    @project_title = project_title
    @git_name = git_name
    @user_name = user_name
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
        "const path = require('path');\nconst HtmlWebpackPlugin = require('html-webpack-plugin');\nconst CleanWebpackPlugin = require('clean-webpack-plugin');\nconst UglifyJsPlugin = require('uglifyjs-webpack-plugin');\n\nmodule.exports = {\n  entry: './src/main.js',\n  output: {\n    filename: 'bundle.js',\n    path: path.resolve(__dirname, 'dist')\n  },\n  devtool: 'eval-source-map',\n  devServer: {\n    contentBase: './dist'\n  },\n  plugins: [\n    new UglifyJsPlugin({ sourceMap: true }),\n    new CleanWebpackPlugin(['dist']),\n    new HtmlWebpackPlugin({\n      title: '#{@project_title}',\n      template: './src/index.html',\n      inject: 'body'\n    })\n  ],\n  module: {\n    rules: [\n      {\n        test: /\.css$/,\n        use: [\n          'style-loader',\n          'css-loader'\n        ]\n      }\n    ]\n  }\n};"
        ) }
        
    File.write(f = "package.json",
      File.read(f).gsub(/'test': 'echo \'Error: no test specified\' && exit 1'/, "'build': 'webpack --mode development',\n    'start': 'npm run build; webpack-dev-server --open'"))
  end
end

puts 'Enter project name: '
project_name = gets.chomp

puts 'Enter project title: '
project_title = gets.chomp

puts 'Enter your name (for the README): '
user_name = gets.chomp

puts 'Enter your GitHub username (for the README): '
git_name = gets.chomp

project = Project.new(project_name, project_title, user_name, git_name)
project.create
