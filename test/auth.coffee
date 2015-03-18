require('babel/register')({
    extensions: [".es6"]
});
assert = require("assert")
http = require('http')
supertest = require("supertest")
db = require("../mattis-auth/lib/db")

agent = supertest.agent require("../server").server

testUser =
  email: "rethinktest@mailinator.com"
  name: "Test User"
  password: "1234321"


describe 'Server', ->
  before (done) ->
    yield db.initTestDb()

  it 'Should not access protected content when not authenticated', (done) ->
    agent
      .get("/accounts/protected")
      .expect(403, done)

  it 'Should load HTML home page', (done) ->
    agent
      .get("/")
      .expect("Content-Type", /^text/)
      .expect(200, done)
  
  userId = null
  it 'Should create an account', (done) ->
    agent.post("/accounts/register").send(testUser)
      .expect(200, done)

  it 'Should be signed in after account creation', (done) ->
    agent
      .get("/accounts/protected")
      .expect(200, done)

  it 'Should sign out', (done) ->
    agent
      .post("/accounts/log-out")
      .expect 200, ->
        agent        
          .get("/accounts/protected")
          .expect(403, done)

  it 'Should sign in with good credentials', (done) ->
    agent
      .post("/accounts/sign-in").send(testUser)
      .expect 200, ->
        agent
          .get("/accounts/protected")
          .expect(200, done)         

  it 'Should reject bad credentials', (done) ->
    console.log "Signing in..."
    agent
      .post("/accounts/sign-in").send({email: "me@matt.is", password: "123"})
      .expect(401, done)
