var router = require('express').Router();
var accountManager = require('../managers/account-manager');

router.post('/login', accountManager.manualLogin);
router.post('/logout', accountManager.logout);
router.post('/signup', accountManager.newAccount);
router.get('/account', accountManager.getAccountInfo);
router.post('/deleteAccount', accountManager.deleteAccount);

module.exports = router;
