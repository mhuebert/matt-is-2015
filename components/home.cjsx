React = require("react")

module.exports = React.createClass
  getInitialState: -> {}
  handleClick: -> @setState message: "Clicked"
  render: ->
    <p onClick={@handleClick}>{@state.message||"Home"}</p>