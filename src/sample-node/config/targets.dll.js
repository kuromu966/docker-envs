const webpack = require('webpack');
const path = require('path');
const {dllEntry} = require('./entry');


/* ********************************************************************
 * Common
 * *******************************************************************/
const Resolve = {
  extensions: ['.js', '.jsx'],
};
const babelLoader = {
  test: /\.jsx*$/,
  exclude: /node_modules/,
  loader: 'babel-loader'
};
const eslintLoader = {
  test: /\.jsx*$/,
  exclude: /node_modules/,
  loader: 'eslint-loader',
  options: {
    fix: true,
    failOnError: true,
  }
};


/* ********************************************************************
 * Target
 * *******************************************************************/
let dllTarget = {
  entry: dllEntry,
  resolve: Resolve,
  output: {
    path: path.resolve(__dirname, '../dist/js'),
    filename: '[name].js',
    library: '[name]_library',
  },
  module: {
    rules: [babelLoader, eslintLoader]
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('production')
    }),
    new webpack.DllPlugin({
      path: path.resolve(__dirname, '../dist/js', '[name]-manifest.json'),
      name: '[name]_library'
    }),
  ]
};


/* ********************************************************************
 * Export
 * *******************************************************************/
module.exports = {dllTarget};
