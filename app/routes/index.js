var router = require('express').Router();

router.use('/', require('./account.routes'));

module.exports = router;
