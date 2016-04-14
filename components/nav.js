var React = require("react")
var {Link} = require("react-router")
var _ = require("lodash")
var prefix = require("react-prefixr")
// var Accounts = require("./accounts")

module.exports = React.createClass({
  getInitialState: function() { 
    return {  menuActive: false,
              mounted: false
           }
  },
  toggleMenuDelayed: function() {
    setTimeout(this.toggleMenu, 100)
  },
  componentDidMount: function() {
    this.setState({mounted: true})
  },
  random: function() {
    return this.state.mounted ? Math.random() : 0.5
  },
  toggleMenu: function() {
    this.setState({menuActive: !this.state.menuActive})
  },
  render: function() {
    var transformLeft = (this.state.menuActive ? 50 : 0)
    var toggle = <a onTouchTap={this.toggleMenu} className="icon-uniE6B2 icon" style={{top:15, left:7, padding: 10, position:"absolute", zIndex: 101}} />
    
    var circle = (radius) => {
      var width = radius*2
      var borderWidth = 15+this.random()*10
      var borderWidthPercent = 25/width
      var maxLeft = this.state.mounted ? Math.min((typeof window == 'undefined' ? 0 : window.innerWidth), 300)-width-borderWidth/2 : 0
        // # transform: "translate3d(#{this.random()*140}px, #{this.random()*20}px, 0)"

      return {
        width: width,
        height: width,
        background:"rgba(0,0,0,0.2)",
        marginBottom: -this.random()*(radius-borderWidth/2),
        textAlign: "center",
        borderRadius: radius,
        paddingTop: 1,
        padding: width*(borderWidthPercent/2)+"px",
        lineHeight: width*(1-borderWidthPercent)+"px",
        opacity: (this.state.menuActive ? 1 : 0),
        transform: `scale(${(this.state.menuActive ? 1 : 0)}) translate3d(${this.random()*maxLeft}px, 0, 0) translateZ(0)`
      }
    }
    return <div style={{height: 10}}>
        {toggle}
        <div className="left-menu">
            <div className="link-container" style={prefix(circle(40))}>
              <Link onTouchTap={this.toggleMenuDelayed} to="/" >Home</Link>
            </div>
            <div className="link-container" style={prefix(circle(50))}>
              <Link onTouchTap={this.toggleMenuDelayed} to="/writing" >    Writing</Link>
            </div>
            <div className="link-container" style={prefix(circle(70))} >
              <Link onTouchTap={this.toggleMenuDelayed} to="/" >    Photography</Link>
            </div>
            <div className="link-container" style={prefix(circle(60))} >
              <Link onTouchTap={this.toggleMenuDelayed} to="meta" > About Matt</Link>
            </div>
        </div>
        
    </div>
  }
})
// <Accounts />