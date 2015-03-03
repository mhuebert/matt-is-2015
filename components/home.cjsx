React = require("react")

module.exports = React.createClass
  getInitialState: -> {}
  handleClick: -> @setState message: "Clicked"
  render: ->
    <div className="grid">
      <div className="unit two-thirds">
        <p onClick={@handleClick}>{@state.message||"Left"}</p>
      </div>
      <div className="unit one-third">
        <p>Right</p>
      </div>
    </div>