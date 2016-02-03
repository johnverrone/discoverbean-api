var express = require('express');
var path = require('path');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var MongoStore = require('connect-mongo')(session);

var dbConfig = require('./config/db');

var app = express();

// app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(session({
	secret: 'faeb4453e5d14fe6f6d04637f71wd7c76c73d1b4',
	proxy: true,
	resave: true,
	saveUninitialized: true,
	store: new MongoStore({url: dbConfig.url})
	})
);

function restrict(req, res, next) {
    if (req.session.account) {
        next();
    } else {
        req.session.error = 'Access denied!';
        res.redirect('/login');
    }
}

var port = process.env.PORT || 8080;

app.use('/api', require('./app/routes'));

// set static directory
app.use(express.static(path.join(__dirname, 'public/dist')));

var server = app.listen(port);
console.log(`listening on port ${port}.`);

module.exports = server;
