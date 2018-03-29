const path = require('path');

const jsEntry = {
  sample: path.resolve(__dirname, '../src/Sample.jsx'),
};

const dllEntry = {
  view: ['react', 'react-dom', 'prop-types', 'react-bootstrap-toggle', 'react-modal', 'react-slick', 'react-loading-overlay'],
  store: ['redux', 'react-redux', 'redux-saga', 'redux-saga/effects', 'redux-sessionstorage',
	  path.resolve(__dirname, '../src/util', 'getJSON.jsx'),
	  path.resolve(__dirname, '../src/util', 'postJSON.jsx'),
	  path.resolve(__dirname, '../src/util', 'now.jsx'),
	  path.resolve(__dirname, '../src/util', 'log.jsx'),
	  path.resolve(__dirname, '../src/util', 'sleep.jsx'),
	  path.resolve(__dirname, '../src/util', 'checkBrowser.jsx'),
  ],
};

module.exports = {jsEntry, dllEntry};
