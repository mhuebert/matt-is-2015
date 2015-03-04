React = require("react")
{Link} = require("react-router")
Photos = require("./photos")

module.exports = React.createClass
  render: ->
    <div>
      <div style={{overflow:"hidden"}}>
        <h3 style={{marginTop:-5}}>Photography</h3>
        <Photos />
      </div>


      <h3 >Writing</h3>
      <div className="paper thick">
        Paper
      </div>
    </div>