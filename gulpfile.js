var gulp = require('gulp');
var util = require('gulp-util');
var elm = require('gulp-elm');

gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], function() {
    return gulp.src('public/src/*.elm')
        .pipe(elm())
        .pipe(gulp.dest('public/dist/'));
});

gulp.task('copy-html', function() {
    return gulp.src('public/src/*.html')
        .pipe(gulp.dest('public/dist/'));
});

gulp.task('build', ['elm', 'copy-html']);

gulp.task('default', ['build']);
