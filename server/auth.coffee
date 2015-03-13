db = require("./db")
passport = require("passport")
bcrypt = require("bcrypt")
LocalStrategy = require('passport-local').Strategy
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
_ = require("lodash")



passport.serializeUser (user, done) ->
  console.log("[DEBUG][passport][serializeUser] %j", user)
  done(null, user.id)

passport.deserializeUser (id, done) ->
  db.findUserById(id, done)

authenticate = (username, password, done) ->
  process.nextTick ->
    validateUser = (err, user) ->
      if (err)
        return done(err)
      if !user
        return done(null, false, {message: "Unknown user: #{username}"})

      if bcrypt.compareSync(password, user.password)
        return done(null, user)

      return done(null, false, {message: "Invalid username or password"})
    db.findUserByEmail(username, validateUser)
  
@ensureAuthenticated = ensureAuthenticated = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.status(403).send("Not allowed")

passport.use = new LocalStrategy(authenticate)
@initialize = (app, callback) ->
  db.setup ->
    app.use(bodyParser.json())
    app.use(bodyParser.urlencoded({ extended: false }))
    app.use(cookieParser())
    app.use(require('express-session')({
        secret: '$#%@$^%#@^',
        resave: false,
        saveUninitialized: false
    }))
    app.use(passport.initialize())
    app.use(passport.session())


    app.post "/login", (req, res, next) ->
      passport.authenticate 'local', (err, user, info) ->
        if err then return next(err)
        if !user
          res.status(401).send "Error"
          return
        req.logIn user, (err) ->
          if err then return next(err)
          res.status(200).send "Success"

    app.post "/register", (req, res, next) ->
      user = _(req.body).pick("email", "password").value()
      user.password = bcrypt.hashSync(user.password, 8)
      db.saveUser user, (err, saved) ->
        console.log("[DEBUG][/register][saveUser] %s", saved)
        if err
          console.error "[ERROR][/register][saveUser]", err
          res.status(500).send("Error creating account.")
          return
        if saved
          res.status(200).json(user)
        else
          res.status(500).send("The account was not created.")

    app.get "/protected", ensureAuthenticated, (req, res, next) ->
      res.status(200).send("You are signed in.")
    
    callback()
