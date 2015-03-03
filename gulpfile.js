var gulp = require('gulp');
var plumber = require('gulp-plumber');
var stylus = require('gulp-stylus');
var autoprefixer = require('gulp-autoprefixer');
var livereload = require("gulp-livereload");
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');
require("node-cjsx").transform()

gulp.task('default', function() {
  gulp.run('styles', 'scripts', 'watch');
  livereload.listen({start: true});
});

gulp.task('styles', function () {
    gulp.src('./client/app.styl')
        .pipe(plumber())
        .pipe(stylus())
        .pipe(gulp.dest('./public/'))
        .pipe(livereload());
});

gulp.task('scripts', function(){
    gulp.src("./client/app.coffee", {read: false})
        .pipe(plumber())
        .pipe(browserify({
            ignore: [],
            transform: ['coffee-reactify'],
            extensions: ['.cjsx', '.coffee', '.js']
        }))
        .pipe(rename("app.js"))
        .pipe(gulp.dest('./public/'))
        .pipe(livereload());
})

gulp.task('watch', function () {
  gulp.watch('./client/**/*.coffee', ['scripts']);
  gulp.watch('./client/**/*.cjsx', ['scripts']);
  gulp.watch('./client/**/*.styl', ['styles']);
});