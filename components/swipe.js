var React = require("react")
var Swipe = require("react-swipe")

module.exports = React.createClass({
  swipe: function(){
    return this.refs.swipe ? this.refs.swipe.swipe : null
  },
  withinImageLoadingRange: function(src, index) {
      var currentPos = this.swipe() ? this.swipe().getPos() : 0
      var numSlides = this.swipe() ? this.swipe().getNumSlides() : 0
      if (Math.abs(currentPos-index) < 2 || (currentPos == (numSlides-1) && index == 0) || (currentPos == 0 && index == (numSlides-1))) {
        return true
      }
  },
  handleSlideChange: function(currentIndex){
      this.setState({currentIndex: currentIndex})
  },
  render: function() {
      return <Swipe ref="swipe" callback={this.handleSlideChange} {... this.props} >
        {
          this.props.children.map((child, index)=>{
              var newProps = {key: index, style: {minHeight: 10}}
              if (!this.withinImageLoadingRange(child.props.src, index)) {
                newProps.src = "/images/blank.png"
              }
              return React.addons.cloneWithProps(child, newProps)
          })
        }
      </Swipe>
  }
})