var r = require('rethinkdbdash')();

var db = undefined
var tableName = undefined

export var config = function(options) {
  db = options.db
  tableName = options.tableName
  setup()
  this
}
var co = require("co")
export var initTestDb = function* (callback) {
  if (db == 'mattis_test') {
    try {
      yield r.dbDrop(db)
    } catch (e) {
      console.log("Database didn't exist")
    }
  }
  yield setup()
  return
}


function* setup() {

  yield r.dbCreate(db)
  var tables = yield r.db(db).tableList()

  if (tables.indexOf(tableName) == -1) {
    yield r.db(db).tableCreate(tableName)
  }

  var indexes = yield r.db(db).table(tableName).indexList()

  if (indexes.indexOf("email") == -1) {
    yield r.db(db).table(tableName).indexCreate('email')
  }
  return
}

export var findUserByEmail = function* (email) {
  console.log(`[INFO ][%s][findUserByEmail] Login ${email}`)
  yield r.db(db).table('users').indexWait("email")
  var users = yield r.db(db).table('users').getAll(email, {index: "email"}).limit(1)
  return users[0]
}

export var findUserById = function* (userId) {
    var user = yield r.db(db).table("users").get(userId)
    return user
}

export var saveUser = function *(user) {
    var result = yield r.db(db).table('users').insert(user)
    user.id = result.generated_keys[0]
    return {
      success: (result.inserted === 1 ? true : false),
      user: user
    } 
}
