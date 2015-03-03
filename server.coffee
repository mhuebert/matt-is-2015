express = require("express")
require("node-cjsx").transform()
React = require("react")
Router = require("react-router")

app = express()
app.use express.static(__dirname + "/public")
routes = require("./routes")

app.get "/", (req, res) ->
  Router.run routes, req.url, (Handler, state) ->
    handler = React.createElement(Handler)
    markup = React.renderToString(handler)
    markup += "<script> Router.run(routes, Router.HistoryLocation, function(Handler) {
                          return React.render(React.createElement(Handler), document);
                        });
               </script>"
    res.setHeader('Content-Type', 'text/html')
    res.send(markup)

app.listen (process.env.port || 3003)