var router = require('express').Router();
var accountManager = require('../managers/account-manager');

router.post('/login', accountManager.manualLogin);
router.post('/signup', accountManager.newAccount);

module.exports = router;
