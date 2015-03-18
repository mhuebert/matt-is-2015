export var host = process.env.RDB_HOST || 'localhost'
export var port = parseInt(process.env.RDB_PORT) || 28015
export var db   = process.env.NODE_ENV == 'test' ? 'mattis_test' : process.env.RDB_DB || 'mattis'
export var tableName = 'users'