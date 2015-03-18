var React = require("react")
var Router = require("react-router")
var { Route, DefaultRoute, Redirect } = Router
var {Layout, Home, Meta, WritingPost, WritingIndex} = require("./components")

module.exports =
  <Route name="layout" handler={Layout} path="/" >
      <DefaultRoute name="home" path="" handler={Home} />
      <Route name="meta" handler={Meta} />
      <Route name="writingPost" path="writing/:slug" handler={WritingPost} />
      <Route name="writing" handler={WritingIndex} />
      <Redirect from="introducing-braintripping" to="writing/introducing-braintripping" />
  </Route>