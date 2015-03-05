React = require("react")
Router = require("react-router")

require("node-cjsx").transform()
require('node-jsx').install({extension: '.jsx'})

fs = require("fs")
express = require("express")
local = require('passport-local').Strategy
passport = require("passport")
bcrypt = require("bcrypt")
util = require("util")
db = require("./server/db")
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

app = express()
app.use express.static(__dirname + "/public")
app.use(favicon(__dirname + '/public/favicon.ico'))
app.use(logger('dev'))
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

routes = require("./routes")
 
app.get "*", (req, res) ->
  Router.run routes, req.url, (Handler, state) ->
    handler = React.createElement(Handler)
    markup = React.renderToString(handler)
    markup += "<script> Router.run(routes, Router.HistoryLocation, function(Handler) {
                          return React.render(React.createElement(Handler), document);
                        });
               </script>"
    res.setHeader('Content-Type', 'text/html')
    res.send(markup)

app.listen (process.env.PORT || 3003)
fs.writeFile(__dirname + '/start.log', 'started');

passport.use new local( (username, password, done) ->
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
)

passport.serializeUser (user, done) ->
  console.log("[DEBUG][passport][serializeUser] %j", user)
  done(null, user.id)
passport.deserializeUser (id, done) ->
  db.findUserById(id, done)
