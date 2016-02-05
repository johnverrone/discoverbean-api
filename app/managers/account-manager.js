var Account = require('../models/account');
var mongoose = require('mongoose');
var dbConfig = require('../../config/db');
var crypto = require('crypto');
var bcrypt = require('bcryptjs');

exports.newAccount = function(req, res) {

    var db = mongoose.connect(dbConfig.url);

    var newAccount = Account({
        name: req.body['name'],
        email: req.body['email'],
        username: req.body['username'],
        password: sha256(req.body['password']),
        admin: true
    });

    newAccount.save(function(err) {
        if (err) {
            if (err.code === 11000) {
                res.status(400).send('username is taken');
                return;
            }
            throw err;
        }

        console.log(req.body['username'] + ' created!');
        res.sendStatus(200);
        db.disconnect();
    });
}

exports.manualLogin = function(req, res) {

    var db = mongoose.connect(dbConfig.url);

    var userQuery = req.body['username'];
    var passQuery = req.body['password'];

    console.log(req.body);

    Account.findOne({username: userQuery}, function(err, account) {
        if (err) {
            throw err;
        }

        if (account == null) {
            res.status(404).send('account not found');
        } else {
            validatePassword(passQuery, account.password, function(valid) {
                if (valid) {
                    req.session.account = account;
                    res.cookie('username', account.username, { maxAge: 900000 });
					res.cookie('password', sha256(account.password), { maxAge: 900000 });
                    res.status(200).json(account);
                } else {
                    res.status(401).send('unauthorized request');
                }
            });
        }
        db.disconnect();
    });
}

exports.deleteAccount = function(req, res) {

    var db = mongoose.connect(dbConfig.url);

    var userQuery = req.body['username'];

    Account.findOneAndRemove({username: userQuery}, function (err) {
        if (err) {
            throw err;
        }

        console.log(userQuery + ' removed!');
        res.sendStatus(200);
        db.disconnect();
    });
}

exports.getAccountInfo = function (req, res) {
    if (req.session.account == null) {
        res.status(400).send('no account found');
    } else {
        res.status(200).send(req.session.account.username);
    }
}

exports.logout = function(req, res) {
    res.clearCookie('username');
    res.clearCookie('password');
    req.session.destroy(function(e) { res.sendStatus(200); });
}


var sha256 = function(str) {
    return crypto.createHash('sha256').update(str).digest('hex');
}

var validatePassword = function (plainPass, encryptedPass, callback) {
    var validHash = sha256(plainPass);
    callback(validHash === encryptedPass);
}
