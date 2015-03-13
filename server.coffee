require("node-cjsx").transform()
require('node-jsx').install({extension: '.jsx'})
fs = require("fs")
express = require("express")
favicon = require('serve-favicon')
logger = require('morgan')

app = express()
app.use "/posts/", express.static(__dirname + "/posts")
app.use express.static(__dirname + "/public")
app.use(favicon(__dirname + '/public/favicon.ico'))
app.use(logger('dev'))

require("./server/auth").initialize app, =>
  PORT = if process.env.NODE_ENV == "test" then 3009 else process.env.PORT || 3003
  require("./server/controller")(app, PORT)
  @server = app.listen(PORT)
  console.log "Listening on port #{PORT}"
  fs.writeFile(__dirname + '/start.log', 'started');

  # Log errors
  app.use (err, req, res, next) ->
    console.error(err.stack)
    next(err)

  # AJAX errors
  app.use (err, req, res, next) ->
    if req.xhr
      res.status(500).send {error: "Error"}
    else
      next(err)

  # Errors
  app.use (err, req, res, next) ->
    console.log "Final error handler"

