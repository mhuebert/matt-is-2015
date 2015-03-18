var passport = require('koa-passport')
var LocalStrategy = require('passport-local').Strategy
var db = require("./db")
var bcrypt = require("bcrypt")
var co = require("co")

function handleError(err) { 
  console.log(err, err.stack )
}

passport.serializeUser(function(user, done) {
  console.log(`serialuse ${user.id}`)
  done(null, user.id)
})

passport.deserializeUser(function(id, done) {
  console.log(`Deserialize ${id}`)
  co.wrap(db.findUserById)(id).then((user)=>{done(null, user)}).catch(handleError)
})

function authenticate(username, password, done) {
  co.wrap(db.findUserByEmail)(username).then(validateUser).catch(handleError)

  function validateUser(user) {
    console.log("validateUser")
      if (!user) return done(null, false, {message: "Unknown user: #{username}"})
      if (bcrypt.compareSync(password, user.password)) return done(null, user)
      return done(null, false, {message: "Invalid username or password"})
  }
}

passport.use(new LocalStrategy({usernameField: "email"}, authenticate))

export var ensureAuthenticated = function *(next) {
  if (this.isAuthenticated()) {
    yield next
  } else {
    this.redirect('/')
  }
}

export var config = function(options){
  db.config(options.dbConfig)
}
  
export var router = require('koa-router')()
var passport = require('koa-passport')
router.use(passport.initialize())
router.use(passport.session())
var bodyParser = require("koa-bodyparser")
router.use(bodyParser())


router.post('/sign-in', function*(next) {
  var ctx = this
  yield* passport.authenticate('local', function*(err, user, info) {
    if (err) throw err
    if (user === false) {
      ctx.status = 401
      ctx.body = { success: false }
    } else {
      yield ctx.login(user)
      ctx.body = { success: true }
    }
  }).call(this, next)
})

router.get('/logout', function*(next) {
  this.logout()
  this.body = { success: true }
})

router.post('/register', function*(next){
  var user = {
    email: this.request.body.email
  }
  user.password = bcrypt.hashSync(this.request.body.password, 8)

  var saved = yield db.saveUser(user)
  if (saved) {
    this.login(saved.user)
    this.status = 200
    this.body = {
      success: true,
      user: user
    }
  } else {
    this.status = 500
    this.body = {success: false}
  }

})


router.get("/protected", function*(next) {
  // console.log("protected", this.isAuthenticated())
  // this.status = 403
  // this.body = "Not allowed"
  if (this.isAuthenticated()) {
    // yield next
    this.status == 200
    this.body = "Authorized"
  } else {
    console.log("Not signed in...")
    this.status = 403
    this.body = {message: "Not authorized"}
  }
})

router.get("/me", function*(next){
  if (this.isAuthenticated()) {
    yield next
  } else {
    this.status = 401
    this.body = {message: "You are not signed in."}
  }
})