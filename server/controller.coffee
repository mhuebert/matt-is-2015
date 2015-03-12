React = require("react")
Router = require("react-router")
routes = require("../routes")
{Promise} = require('es6-promise')

module.exports = (app, PORT) ->
  fetchData = (routes, params, callback) ->
    data = {}
    Promise.all(routes
                    .filter (route) -> route.handler.fetchData
                    .map (route) ->
                      new Promise (resolve, reject) -> 
                        route.handler.fetchData params, (d) -> 
                          data[route.name] = d; resolve();
                    ).then -> callback(data)

  app.get "*", (req, res) ->
    Router.run routes, req.url, (Handler, state) ->
      state.serverAddress = "http://localhost:#{PORT}"
      fetchData state.routes, state, (data) ->
        handler = React.createElement(Handler, data)
        markup = React.renderToString(handler)
        markup += "<script> Router.run(routes, Router.HistoryLocation, function(Handler, state) {
                              return React.render(React.createElement(Handler, #{JSON.stringify(data)}), document);
                            });
                   </script>"
        res.setHeader('Content-Type', 'text/html')
        res.send(markup)