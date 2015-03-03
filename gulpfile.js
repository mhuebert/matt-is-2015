var gulp = require('gulp');
var gutil = require('gulp-util');
var plumber = require('gulp-plumber');
var stylus = require('gulp-stylus');
var autoprefixer = require('gulp-autoprefixer');
var livereload = require("gulp-livereload");
var browserify = require('browserify');
var rename = require('gulp-rename');
var watch = require("gulp-watch");
var watchify = require('watchify');
var source = require('vinyl-source-stream')
require("node-cjsx").transform()
var uglify = require("gulp-uglify");
var streamify = require("gulp-streamify");

// console.log(watchify.args)
watchify.args.extensions = ['.cjsx', '.coffee', '.js']

var bundler = watchify(browserify("./client/app.coffee", watchify.args))
    .transform({ }, "coffee-reactify")
    // .extensions([".cjsx", ".coffee", ".js"])

bundler.transform('brfs');
gulp.task('js', bundle);
bundler.on('update', bundle);
bundler.on('log', gutil.log);
function bundle() {
    return bundler.bundle()
    .on('error', gutil.log.bind(gutil, 'Browserify Error'))
    .pipe(source('app.js'))
    .pipe(gulp.dest("./public"))
    .pipe(livereload())
    .pipe(rename("app.min.js"))
    .pipe(streamify(uglify()))
    .pipe(gulp.dest("./public"));
}

gulp.task('styles', function () {
    console.log("styles")
    gulp.src('./client/app.styl')
        .pipe(plumber())
        .pipe(stylus({"include css": true}))
        .pipe(gulp.dest('./public/'))
        .pipe(livereload());
});

gulp.task('default', function () {
  gulp.watch('client/**/*.styl', ['styles']);
  gulp.start(['js', 'styles'])
  livereload.listen({start: true});
});