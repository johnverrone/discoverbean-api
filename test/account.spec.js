var request = require('supertest');
require = require('really-need');

describe('/api/account ::', function() {
    var server;

    beforeEach(function() {
        server = require('../server', {bustCache : true});
    });

    afterEach(function(done) {
        server.close(done);
    });


    it('GET /api/account success', function(done) {
        var testUser = {
            name: "John Verrone",
            email: "john.verrone@gmail.com",
            username: "john.verrone",
            password: "pass123",
            _id: "56ab7759d63b17df286c7518",
            admin: true,
            __v: 0
        };

        request(server)
            .get('/api/account?username=john.verrone&password=pass123')
            .expect(200, testUser, done);
    });

    it('GET /api/account unauthorized', function(done) {
        var testUser = {
            name: "John Verrone",
            email: "john.verrone@gmail.com",
            username: "john.verrone",
            password: "pass123",
            _id: "56ab7759d63b17df286c7518",
            admin: true,
            __v: 0
        };

        request(server)
            .get('/api/account?username=john.verrone&password=INCORRECTPASSWORD')
            .expect(401, done);
    });
})
