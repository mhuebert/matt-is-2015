React = require("react")
{ Route, DefaultRoute, Redirect } = Router = require("react-router")
{Layout, Home, Meta, WritingPost, WritingIndex} = require("./components")

module.exports =
  <Route handler={Layout} path="/" >
      <DefaultRoute name="" handler={Home} />
      <Route name="meta" handler={Meta} />
      <Route name="writing/:slug" handler={WritingPost} />
      <Route name="writing" handler={WritingIndex} />
      <Redirect from="introducing-braintripping" to="writing/introducing-braintripping" />
  </Route>