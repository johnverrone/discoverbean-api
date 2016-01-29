var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var accountSchema = new Schema({
    name: String,
    email: String,
    username: String,
    password: String,
    admin: Boolean
});

var Account = mongoose.model('Account', accountSchema);

module.exports = Account;
