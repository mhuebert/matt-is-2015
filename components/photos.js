var React = require("react/addons")
var prefix = require("react-prefixr")
var Swipe = require("./swipe")

module.exports = React.createClass({
  getInitialState: function() {return {}},
  swipe: function(){
    return this.refs.swipe.swipe()
  },
  next: function(e){
    this.swipe().next()
    e.preventDefault()
  },
  prev: function(e){
    this.swipe().prev()
    e.preventDefault()
  },
  render: function(){
      return <div >
        <Swipe ref="swipe" onClick={this.next}>
          <img src='/photography/bg_sky_only.jpg' />
          <img src='/photography/banana.jpg' />
          <img src='/photography/Guatemala-002.jpg' />
          <img src='/photography/Guatemala-006.jpg' />
          <img src='/photography/fire.jpg' />
          <img src='/photography/plane.jpg' />
          <img src='/photography/kids.jpg' />
          <img src='/photography/snowbird.jpg' />
          <img src='/photography/moonvalley.jpg' />
          <img src='/photography/baby.jpg' />
          <img src='/photography/bird.jpg' />
          <img src='/photography/waves.jpg' />
          <img src='/photography/epp.jpg' />
          <img src='/photography/Victoria-003.jpg' />
          <img src='/photography/cheryl.jpg' />
          <img src='/photography/flower.jpg' />
          <img src='/photography/matt-epp.jpg' />
        </Swipe>
        <div className="slider-nav">
          <span style={{float: "right" }} onMouseDown={this.next} className="slider-move icon-uniE720" />
          <span style={{float: "left" }} onMouseDown={this.prev} className="slider-move icon-uniE71F" />
        </div>
      </div>
    }
})