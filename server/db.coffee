r = require("rethinkdb")
util = require("util")
assert = require("assert")
logdebug = require("debug")('rdb:debug')
logerror = require("debug")('rdb:error')

dbConfig = 
  host: process.env.RDB_HOST || 'localhost'
  port: parseInt(process.env.RDB_PORT) || 28015
  db: process.env.RDB_DB || 'mattis'
  tables:
    user: 'id'
    posts: 'id'


@setup = ->
  r.connect { host: dbConfig.host, port: dbConfig.port }, (err, connection) ->

    assert.ok(err == null, err)

    r.dbCreate(dbConfig.db).run connection, (err, result) ->
      if (err)
        logdebug "[DEBUG] RethinkDB database '%s' already exists (%s:%s)\n%s", dbConfig.db, err.name, err.msg, err.message
      else
        logdebug "[INFO ] RethinkDB database '%s' created", dbConfig.db

      for tbl in dbConfig.tables
        do (tbl) ->
          r.db(dbConfig.db).tableCreate(tableName, {primaryKey: dbConfig.tables[tbl]}).run connection, (err, result) ->
            if (err)
              logdebug "[DEBUG] RethinkDB table '%s' already exists (%s:%s)\n%s", tableName, err.name, err.msg, err.message
            else
              logdebug("[INFO ] RethinkDB table '%s' created", tableName)

@findUserByEmail = (mail, callback) ->
  onConnect (err, connection) ->
    logdebug("[INFO ][%s][findUserByEmail] Login {user: %s, pwd: 'you really thought I'd log it?'}", connection['_id'], mail)
    r.db(dbConfig.db).table('users').filter({'mail': mail}).limit(1).run connection, (err, cursor) ->
      if err
        logerror "[ERROR][%s][findUserByEmail][collect] %s:%s\n%s", connection['_id'], err.name, err.msg, err.message
        callback(err)
      else
        cursor.next (err, row) ->
          if err
            logerror("[ERROR][%s][findUserByEmail][collect] %s:%s\n%s", connection['_id'], err.name, err.msg, err.message)
            callback(err)
          else
            callback(null, row)
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

onConnect = (callback) ->
  r.connect {host: dbConfig.host, port: dbConfig.port}, (err, connection) ->
    assert.ok(err == null, err)
    connection['_id'] = Math.floor(Math.random()*10001)
    callback(err, connection)

