React = require("react")
require("react-tap-event-plugin")()
Head = require("./head")
Sidebar = require("./sidebar")
Nav = require("./nav")
{ RouteHandler } = Router = require("react-router")
FastClickAttach = require('fastclick') 

module.exports = React.createClass
  mixins: [Router.Navigation]
  componentDidMount: ->
    FastClickAttach(document.body)
  render: ->
    <html>
      <Head title="Matt Huebert | Designing Serendipity" />
      <body className="wrap"> 
        <Nav/>
        <div className="grid">
          <div className="unit two-thirds">
            <RouteHandler {... @props}/>
          </div>
          <div className="unit one-third align-center">
            <Sidebar/>
          </div>
        </div>
      </body>
    </html>


