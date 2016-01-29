var router = require('express').Router();
var accountManager = require('../managers/account-manager');

router.get('/', accountManager.manualLogin);
router.post('/', accountManager.newAccount);

module.exports = router;
