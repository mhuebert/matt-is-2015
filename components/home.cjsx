React = require("react")
{Link} = require("react-router")
Photos = require("./photos")
WritingIndex = require("./writing").Index

module.exports = React.createClass
  render: ->
    <div>
      <div style={{overflow:"hidden"}}>
        <h3 style={{marginTop:-5}}>Photography</h3>
        <Photos />
      </div>
      <WritingIndex />
    </div>