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
    transformLeft = (if @state.menuActive then 50 else 0)
    toggle = <a onTouchTap={@toggleMenu} className="icon-uniE6B2 icon" style={{top:9, left:17,position:"absolute"}} />
    circle = (radius) =>
      width: radius*2
      height: radius*2
      background: "white"
      background:"rgba(0,0,0,0.2)"
      marginTop: -20
      textAlign: "center"
      borderRadius: radius
      paddingTop: 1
      lineHeight: radius*2*0.8+"px"
      opacity: (if @state.menuActive then 1 else 0)
      transform: "scale(#{(if @state.menuActive then 1 else 0)}) translate3d(#{@random()*150}px, #{@random()*20}px, 0) translateZ(0)"
      # transform: "translate3d(#{@random()*140}px, #{@random()*20}px, 0)"
    <div style={height: 10}>
        {toggle}
        <div className="left-menu">
            <div className="link-container" style={prefix(circle(40))}>
              <Link onTouchTap={@toggleMenuDelayed} to="/" >Home</Link>
            </div>
            <div className="link-container" style={prefix(circle(50))}>
              <Link onTouchTap={@toggleMenuDelayed} to="/" >    Writing</Link>
            </div>
            <div className="link-container" style={prefix(circle(70))} >
              <Link onTouchTap={@toggleMenuDelayed} to="/" >    Photography</Link>
            </div>
            <div className="link-container" style={prefix(circle(60))} >
              <Link onTouchTap={@toggleMenuDelayed} to="meta" > About Matt</Link>
            </div>
        </div>
    </div>