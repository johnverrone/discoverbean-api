var express = require('express');
var path = require('path');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var app = express();

// app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

var port = process.env.PORT || 8080;

app.use('/api', require('./app/routes'));

var server = app.listen(port);
console.log('API is served on ' + port);

module.exports = server;
