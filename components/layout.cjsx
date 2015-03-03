React = require("react")
Head = require("./head")
{ RouteHandler } = Router = require("react-router")

module.exports = React.createClass
  mixins: [Router.Navigation]
  render: ->
    <html>
      <Head title="Matt Huebert | Designing Serendipity" />
      <body className="wrap"> 
        <div className="grid">
          <RouteHandler/>
        </div> 
        <script src="/app.js"></script>
      </body>
    </html>


