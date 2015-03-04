React = require("react")
Head = require("./head")
Sidebar = require("./sidebar")
Nav = require("./nav")
{ RouteHandler } = Router = require("react-router")


module.exports = React.createClass
  mixins: [Router.Navigation]
  render: ->
    <html>
      <Head title="Matt Huebert | Designing Serendipity" />
      <body className="wrap"> 
        <Nav/>
        <div className="grid">
          <div className="unit two-thirds">
            <RouteHandler/>
          </div>
          <div className="unit one-third align-center">
            <Sidebar/>
          </div>
        </div>
      </body>
    </html>


