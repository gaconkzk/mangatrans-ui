'use strict';

// require('ace-css/css/ace.css');
// require('font-awesome/css/font-awesome.css');

// require index.html so it gets copied to dist
require('./css/bookshelf.css')
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// .embed() can take an optional second argument. Thise would be an object describing the data we need to start a program, i.e. a userId or some token
var app = Elm.Main.embed(mountNode);