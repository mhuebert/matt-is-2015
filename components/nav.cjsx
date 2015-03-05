React = require("react")
{Link} = require("react-router")
_ = require("lodash")
prefix = require("react-prefixr")

module.exports = React.createClass
  getInitialState: -> 
    menuActive: false
    mounted: false
  toggleMenuDelayed: ->
    setTimeout @toggleMenu, 100
  componentDidMount: ->
    @setState mounted: true
  random: ->
    if @state.mounted then Math.random() else 0.5
  toggleMenu: ->
    @setState menuActive: !@state.menuActive
  render: ->
    transformLeft = (if @state.menuActive then 0 else -150)
    toggle = <a onTouchTap={@toggleMenu} className="icon-uniE6B2 icon" style={{top:9, left:17,position:"absolute"}} />
    circle = (radius) =>
      width: radius*2
      height: radius*2
      background: "white"
      boxShadow: "0 0 5px rgba(0,0,0,0.2)"
      textAlign: "center"
      borderRadius: radius
      lineHeight: radius*2+"px"
      marginLeft: @random()*40 + 10
      marginTop: @random()*20
      opacity: (if @state.menuActive then 1 else 0)
    <div style={height: 10}>
        {toggle}
        <div style={prefix({transform: "translate3d(#{transformLeft}px,0,0)"})} className="left-menu">
            <Link style={circle(30)} onTouchTap={@toggleMenuDelayed} to="/" >    Home</Link>
            <Link style={circle(40)} onTouchTap={@toggleMenuDelayed} to="/" >    Writing</Link>
            <Link style={circle(60)} onTouchTap={@toggleMenuDelayed} to="/" >    Photography</Link>
            <Link style={circle(50)} onTouchTap={@toggleMenuDelayed} to="meta" > About Matt</Link>
        </div>
    </div>