r = require("rethinkdb")
util = require("util")
assert = require("assert")
logdebug = require("debug")('rdb:debug')
logerror = require("debug")('rdb:error')
async = require("async")
_ = require("lodash")

dbConfig = 
  host: process.env.RDB_HOST || 'localhost'
  port: parseInt(process.env.RDB_PORT) || 28015
  db: if process.env.NODE_ENV == 'test' then 'mattis_test' else process.env.RDB_DB || 'mattis'
  tables: ['users']

@drop = (callback) ->
  onConnect (err, connection) ->
    if dbConfig.db == 'mattis_test'
      r.dbDrop(dbConfig.db).run(connection, callback)
    else
      console.log "Trying to delete a non-test database"
@setup = (callback) ->
  r.connect { host: dbConfig.host, port: dbConfig.port }, (err, connection) ->
    if err
      console.log "DB not functioning"
      callback(err)
      return
    assert.ok(err == null, err)

    r.dbCreate(dbConfig.db).run connection, (err, result) ->
      if (err)
        logdebug "[DEBUG] RethinkDB database '%s' already exists (%s:%s)\n%s", dbConfig.db, err.name, err.msg, err.message
      else
        logdebug "[INFO ] RethinkDB database '%s' created", dbConfig.db

      makeTable = (tableName, callback) ->
        # console.log "Create table #{tableName}"
        r.db(dbConfig.db).tableCreate(tableName).run connection, (err, result) ->
          if (err)
            logdebug "[DEBUG] RethinkDB table '%s' already exists (%s:%s)\n%s", tableName, err.name, err.msg, err.message
          else
            logdebug("[INFO ] RethinkDB table '%s' created", tableName)
          callback()
      async.map dbConfig.tables, makeTable, (err, results) ->
        if err
          console.log "Err in DB setup"
          console.log err
        r.db(dbConfig.db).table('users').indexList().run connection, (err, indexes) ->
          if 'email' not in indexes
            r.db(dbConfig.db).table('users').indexCreate('email').run(connection)

          callback(err, results)

@findUserByEmail = (email, callback) ->
  onConnect (err, connection) ->
    logdebug("[INFO ][%s][findUserByEmail] Login {user: %s, pwd: 'you really thought I'd log it?'}", connection['_id'], email)
    r.db(dbConfig.db).table('users').indexWait("email").run connection, ->
      r.db(dbConfig.db).table('users').getAll(email, {index: "email"}).limit(1).run connection, (err, cursor) ->
        if err
          logerror "[ERROR][%s][findUserByEmail][collect] %s:%s\n%s", connection['_id'], err.name, err.msg, err.message
          callback(err)
        else
          cursor.toArray (err, users) ->
            if !users[0]
              callback(null, false)
            else
              callback(null, users[0])
            connection.close()

@findUserById = (userId, callback) ->
  onConnect (err, connection) ->
    r.db(dbConfig['db']).table("users").get(userId).run connection, (err, result) ->
      if err
        logerror("[ERROR][%s][findUserById] %s:%s\n%s", connection['_id'], err.name, err.msg, err.message)
        callback(null, null)
      else
        callback(null, result)
      connection.close()

@saveUser = (user, callback) ->
  onConnect (err, connection) ->
    r.db(dbConfig.db).table('users').insert(user).run connection, (err, result) ->
      if err
        logerror "[ERROR][%s][saveUser] %s:%s\n%s", connection['_id'], err.name, err.msg, err.message
        callback(err)
      else
        if result.inserted == 1
          callback(null, true)
        else
          callback(null, false)
      connection.close()

onConnect = (callback) ->
  r.connect {host: dbConfig.host, port: dbConfig.port}, (err, connection) ->
    assert.ok(err == null, err)
    connection['_id'] = Math.floor(Math.random()*10001)
    callback(err, connection)

