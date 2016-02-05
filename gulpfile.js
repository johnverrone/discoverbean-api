var gulp = require('gulp');
var util = require('gulp-util');
var nodemon = require('gulp-nodemon');
var livereload = require('gulp-livereload');

gulp.task('dev', function() {
    livereload.listen();

    nodemon({
        script: 'server.js',
        env: { 'NODE_ENV': 'development' },
        stdout: false
    });
});


gulp.task('default', ['dev']);
