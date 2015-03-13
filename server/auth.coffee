db = require("./db")
passport = require("passport")
bcrypt = require("bcrypt")
LocalStrategy = require('passport-local').Strategy
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
_ = require("lodash")

passport.serializeUser (user, done) ->
  # console.log("[DEBUG][passport][serializeUser] %j", user)
  done(null, user.email)

passport.deserializeUser (email, done) ->
  db.findUserByEmail(email, done)

authenticate = (username, password, done) ->
  validateUser = (err, user) ->
    if (err)
      return done(err)
    if !user
      return done(null, false, {message: "Unknown user: #{username}"})

    if bcrypt.compareSync(password, user.password)
      return done(null, user)

    return done(null, false, {message: "Invalid username or password"})
  db.findUserByEmail(username, validateUser)

passport.use(new LocalStrategy({usernameField: "email"}, authenticate))

@ensureAuthenticated = ensureAuthenticated = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.status(403).send("Not allowed")

@initialize = (app, callback) ->
  
  db.setup (err) ->
    if err
      console.log "No authentication"
      callback(err)
      return
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

    # app.post "/sign-in", passport.authenticate('local', {}), (req, res, next) ->
    #   res.status(200).json(req.user)

    app.post "/sign-in", (req, res, next) ->
      (passport.authenticate 'local', (err, user, info) ->
        if err
          res.status(500).send("Authentication error")
        else if user
          req.logIn user, (err) ->
            res.status(200).json(req.user)
        else
          res.status(401).send("You are not signed in")
      )(req, res, next)
        

    app.post "/log-out", (req, res, next) ->
      req.logOut()
      res.status(200).send("You are now signed out.")

    app.post "/register", (req, res, next) ->
      user = _(req.body).pick("email", "password").value()
      user.password = bcrypt.hashSync(user.password, 8)
      db.saveUser user, (err, saved) ->
        # console.log("[DEBUG][/register 1][saveUser] %s", saved)
        if err
          console.log "[ERROR][/register 2][saveUser]", err
          res.status(500).send("Error creating account.")
          return
        if saved
          req.logIn user, (err) ->
            if err
              console.log "[ERROR][/register 3][saveUser]", err
              res.status(500).send("Error signing in")
              return
            res.status(200).json(user)
        else
          res.status(500).send("The account was not created.")

    app.get "/protected", ensureAuthenticated, (req, res, next) ->
      res.status(200).send("You are signed in.")

    app.get "/authenticated", (req, res, next) ->
      if req.user
        res.json(req.user)
      else
        res.status(401).send(false)
      
    callback()
