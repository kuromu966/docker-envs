const webpack = require('webpack');
const path = require('path');
const {jsEntry, dllEntry} = require('./entry');

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
 * Development Version
 * *******************************************************************/
let jsDevelTarget = {
  entry: jsEntry,
  output: {
    path: path.resolve(__dirname, '../dist'),
    filename: 'js/[name].min.js'
  },
  devtool: 'inline-source-map',
  resolve: Resolve,
  module: {
    rules: [babelLoader, eslintLoader]
  },
  /* plugins: [
   *   new webpack.ProvidePlugin({
   *     $: 'jquery',
   *     jQuery: 'jquery',
   *     'window.jQuery': 'jquery'
   *   })
   * ]*/
};

let jsDevelServerTarget = {
  entry: jsEntry,
  output: {
    path: path.resolve(__dirname, '../dist'),
    filename: 'js/[name].min.js'
  },
  devtool: 'inline-source-map',
  resolve: Resolve,
  module: {
    rules: [babelLoader, eslintLoader]
  },
  devServer: {
    contentBase: path.resolve(__dirname, '../dist'),
    output: {
      publicPath: "/lib"
    },
    port: 3000
  }
};

/* ********************************************************************
 * Product Version
 * *******************************************************************/
let jsProductionTarget = {
  entry: jsEntry,
  output: {
    path: path.resolve(__dirname, '../dist'),
    publicPath: '/redux',
    filename: 'js/[name].min.js'
  },
  resolve: Resolve,
  module: {
    rules: [babelLoader]
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('production')
    })
  ]
};

Object.keys(dllEntry).map( (name) => {
  jsProductionTarget.plugins.push(
    new webpack.DllReferencePlugin({
      context: path.resolve(__dirname, '../'),
      manifest: path.resolve(__dirname, '../dist/js', name+'-manifest.json'),
    })
  );
}),

/* ********************************************************************
 * Export
 * *******************************************************************/
module.exports = {
  jsDevelTarget,
  jsDevelServerTarget,
  jsProductionTarget
};
