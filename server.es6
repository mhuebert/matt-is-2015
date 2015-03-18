require("node-cjsx").transform()
require('node-jsx').install({extension: '.jsx'})

// var authApp = require("./mattis-auth").init({dbConfig: require("./server/dbConfig")})
// app.use("/accounts", authApp)

var PORT = process.env.NODE_ENV == "test" ? 3009 : (process.env.PORT || 3003)

var koa = require('koa')
var app = koa()
var serve = require('koa-static')
var mount = require('koa-mount')

// Static files
app.use(mount("/posts", serve(__dirname + "/posts")))
app.use(                serve(__dirname + "/public"))
app.use(require('koa-favicon')(__dirname + '/public/favicon.ico'))


// Authentication
var session = require('koa-session')
app.keys = ['I am a little secret', 'not a teapot.']
app.use(session(app))

var auth = require("./mattis-auth")
auth.config({dbConfig: require("./server/dbConfig")})
app.use(require("./server/errorHandler")())
app.use(mount("/accounts", auth.router.routes()))
var koaRouter = require("./server/controller")(`http://localhost:${PORT}`).routes()
app.use(koaRouter)

export var server = app.listen(PORT)
console.log(`Listening on port ${PORT}`)

require("fs").writeFile(__dirname + '/start.log', 'started')
