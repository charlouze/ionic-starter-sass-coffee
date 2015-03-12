gulp = require 'gulp'
gutil = require 'gulp-util'
bower = require 'bower'
concat = require 'gulp-concat'
sass = require 'gulp-sass'
rename = require 'gulp-rename'
sh = require 'shelljs'
coffee = require 'gulp-coffee'
ngClassify = require 'gulp-ng-classify'
sourcemaps = require 'gulp-sourcemaps'
plumber = require 'gulp-plumber'

paths =
  src:
    sass: ['./src/scss/**/*.scss']
    coffee: ['./src/coffee/**/*.coffee']
  dst:
    sass: 'www/css/'
    coffee: 'www/js/'

gulp.task 'default', ['sass', 'coffee']

gulp.task 'sass', (done) ->
  gulp.src paths.src.sass
  .pipe plumber()
  .pipe sass()
  .pipe gulp.dest paths.dst.sass
  .on 'end', done
  return

gulp.task 'coffee', (done) ->
  gulp.src paths.src.coffee
  .pipe plumber()
  .pipe sourcemaps.init()
  .pipe ngClassify()
  .pipe coffee
    bare: true
  .pipe concat 'app.js'
  .pipe sourcemaps.write()
  .pipe gulp.dest paths.dst.coffee
  .on 'end', done
  return

gulp.task 'watch', ['sass', 'coffee'], () ->
  gulp.watch paths.sass, ['sass']
  gulp.watch paths.coffee, ['coffee']
  return

gulp.task 'install', ['git-check'], () ->
  bower.commands.install()
  .on 'log', (data) ->
    gutil.log 'bower', gutil.colors.cyan(data.id), data.message
    return

gulp.task 'git-check', (done) ->
  if not sh.which 'git'
    console.log """
                #{gutil.colors.red('Git is not installed.')}
                  Git, the version control system, is required to download Ionic.
                  Download git here: #{gutil.colors.cyan('http://git-scm.com/downloads')}
                  Once git is installed, run '#{gutil.colors.cyan('gulp install')}' again.
                """
    process.exit 1
  done()
  return
