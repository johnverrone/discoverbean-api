var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var accountSchema = new Schema({
    name: { type: String, required: true },
    email: { type: String, unique: true, required: true },
    username: { type: String, unique: true, required: true },
    password: { type: String, unique: true, required: true },
    admin: Boolean
});

var Account = mongoose.model('Account', accountSchema);

module.exports = Account;
