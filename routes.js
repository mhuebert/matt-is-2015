var React = require("react")
var Router = require("react-router")
var { Route, DefaultRoute, Redirect } = Router
var {Layout, Home, Meta, WritingPost, WritingIndex} = require("./components/")

module.exports = <Route name="layout" handler={Layout} path="/" >
      <DefaultRoute name="home" path="" handler={Home} />
      <Route name="meta" handler={Meta} />
      <Route name="writingPost" path="writing/:slug" handler={WritingPost} />
      <Route name="writing" handler={WritingIndex} />
      <Redirect from="introducing-braintripping" to="writing/introducing-braintripping" />
  </Route>

// module.exports = React.createElement(
//       Route,
//       { name: "layout", handler: Layout, path: "/" },
//       React.createElement(DefaultRoute, { name: "home", path: "", handler: Home }),
//       React.createElement(Route, { name: "meta", handler: Meta }),
//       React.createElement(Route, { name: "writingPost", path: "writing/:slug", handler: WritingPost }),
//       React.createElement(Route, { name: "writing", handler: WritingIndex }),
//       React.createElement(Redirect, { from: "introducing-braintripping", to: "writing/introducing-braintripping" })
// );