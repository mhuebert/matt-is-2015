var React = require("react")
require("react-tap-event-plugin")()
var Head = require("./head")
var Sidebar = require("./sidebar")
var Nav = require("./nav")
var Router = require("react-router")
var { RouteHandler } = Router
var FastClickAttach = require('fastclick') 

module.exports = React.createClass({
  mixins: [Router.Navigation],
  componentDidMount: function(){
      FastClickAttach(document.body)
  },
  render: function(){
    return <html>
      <Head title="Matt Huebert | Design for ________." />
      <body className="wrap"> 
        <Nav/>
        <div className="grid">
          <div className="unit two-thirds">
            <RouteHandler {... this.props}/>
          </div>
          <div className="unit one-third align-center">
            <Sidebar/>
          </div>
        </div>
      </body>
    </html>
  }
})