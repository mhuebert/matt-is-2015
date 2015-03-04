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
var source = require('vinyl-source-stream');
var uglify = require("gulp-uglify");
var streamify = require("gulp-streamify");

require("node-cjsx").transform();

watchify.args.extensions = ['.cjsx', '.coffee', '.js']
var bundler = browserify("./client/app.coffee", watchify.args)
    .transform({ }, "coffee-reactify")

if (!process.env.PORT) {
  bundler = watchify(bundler)
}

gulp.task('js', bundle);
bundler.transform('brfs');
bundler.on('update', bundle);
bundler.on('log', gutil.log);
function bundle() {
    return bundler.bundle()
    .on('error', gutil.log.bind(gutil, 'Browserify Error'))
    .pipe(source('app.js'))
    .pipe(gulp.dest("./public"))
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
gulp.task("reload", function() {
    livereload.reload()
})

gulp.task('default', function () {
  gulp.start(['js', 'styles']);
  if (!process.env.PORT) {
    gulp.watch('start.log', ['reload']);
    gulp.watch('client/**/*.styl', ['styles']);
    gulp.watch('client/**/*.css', ['styles']);
    livereload.listen({start: true});
  }
});