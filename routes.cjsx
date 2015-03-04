React = require("react")
{ Route, DefaultRoute } = Router = require("react-router")
{Layout, Home, Meta} = require("./components")

module.exports =
  <Route handler={Layout} path="/" >
      <DefaultRoute name="" handler={Home} />
      <Route name="meta" handler={Meta} />
  </Route>