var Account = require('../models/account');
var mongoose = require('mongoose');
var dbConfig = require('../../config/db');

exports.newAccount = function(req, res) {

    var db = mongoose.connect(dbConfig.url);

    var newAccount = Account({
        name: req.body['name'],
        email: req.body['email'],
        username: req.body['username'],
        password: req.body['password'],
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

        console.log('Account created!');
        res.sendStatus(200);
        db.disconnect();
    });
}

exports.manualLogin = function(req, res) {

    var db = mongoose.connect(dbConfig.url);

    var userQuery = req.body['username'];
    var passQuery = req.body['password'];

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
					res.cookie('password', account.password, { maxAge: 900000 });
                    res.status(200).json(account);
                } else {
                    res.status(401).send('unauthorized request');
                }
            });
        }
        db.disconnect();
    });
}

var validatePassword = function (plainPass, encryptedPass, callback) {
    callback(plainPass === encryptedPass);
}
