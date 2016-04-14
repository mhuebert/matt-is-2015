var React = require("react")
var {Link} = require("react-router")
var Photos = require("./photos")
var WritingIndex = require("./writing").Index

module.exports = React.createClass({
  render: function(){
    return <div>
      <div style={{overflow:"hidden"}}>
        <h3 >Photography</h3>
        <Photos />
      </div>
      <WritingIndex />
    </div>
  }
})