assert = require("assert")
http = require('http')
supertest = require("supertest")
db = require("../server/db")

main = require("../server")
agent = undefined

testUser =
  email: "rethinktest@mailinator.com"
  name: "Test User"
  password: "1234321"

describe 'Server', ->
  before (done) ->
    waiting = setInterval ->
      if main.server?
        server = main.server
        agent = supertest.agent(server)
        clearInterval(waiting)
        db.drop ->
          db.setup ->     
            done()
    , 200  

  it 'Should not access protected content when not authenticated', (done) ->
    agent
      .get("/protected")
      .expect(403, done)
  
  it 'Should load HTML home page', (done) ->
    agent
      .get("/")
      .expect("Content-Type", /^text/)
      .expect(200, done)
  
  userId = null
  it 'Should create an account', (done) ->
    agent.post("/register").send(testUser)
      .expect(200, done)
      # .end (err, res) ->
      #   console.log arguments
      #   # console.log err if err?
      #   # userId = /href="\/user\/([\w]+)"/.exec(res.text)[1]
      #   # assert.notEqual null, userId
      #   # assert.equal err, null
      #   # assert.notEqual -1, res.text.indexOf('href="/logout"')
      #   done()