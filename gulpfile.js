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
var babelify = require("babelify");
var path = require("path")

// var bundler = browserify()
//     .transform(babelify({extensions: [".es6"]}))
//     .transform({ }, "coffee-reactify")
//     .require(path.join(__dirname, "./client/test.es6"), watchify.args)


browserifyArgs = {
    cache: {},
    packageCache: {},
    fullPaths: true,
    entry: true
}
var bundler = browserify()
            .transform(babelify.configure({extensions: [".es6", ".js"]}))
            .require(path.join(__dirname, "./client/app.es6"), browserifyArgs)

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
    // .pipe(rename("app.min.js"))
    // .pipe(streamify(uglify()))
    // .pipe(gulp.dest("./public"));
}

gulp.task('styles', function () {
    console.log("styles")
    gulp.src('./client/app.styl')
        .pipe(plumber())
        .pipe(stylus({"include css": true}))
        .pipe(autoprefixer())
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