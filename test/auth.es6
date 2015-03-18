var supertest = require("co-supertest")
var db = require("../mattis-auth/lib/db")
var app = require("../server").server
var agent = supertest.agent(app)
var assert = require("assert")
var should = require('should')

var testUser ={
   email: "rethinktest@mailinator.com",
   name: "Test User",
   password: "1234321"
}

describe("Matt.is website", function(){

  before(function*(){
    yield db.initTestDb();
  })

  it("Should not access protected content while signed-out", function*(){
    var res = yield agent.get("/accounts/protected").end()
    assert.equal(res.status, 403)
  })

  it("Should load HTML home page", function*(){
    var res = yield agent.get("/").end()
    // (res.headers['content-type']).should.match(/text/)
    res.headers['content-type'].should.match(/^text/)
  })

  it("Should create an account", function*(){
    var res = yield agent.post("/accounts/register").send(testUser).end()
    res.body.success.should.equal(true)
    res.status.should.equal(200)

  })

  // it("Should be signed in after account creation", function*(){
  //   var res = yield agent.get("/accounts/protected").end()
  //   res.status.should.equal(200)
  // })

  // it("Should sign out", function*(){
  //   var res = yield agent
  // })

  it("Should sign in with good credentials", function*(){
    var res = yield agent.post("/accounts/sign-in").send(testUser).end()
    res.status.should.equal(200)
    console.log(1)
    var res2 = yield agent.get("/accounts/protected").end()
    console.log(res2.body, res2.status)
    console.log(2)
    res2.status.should.equal(200)
  })

  // it("Should reject bad credentials", function*(){
  //   var res = yield agent
  // })
})