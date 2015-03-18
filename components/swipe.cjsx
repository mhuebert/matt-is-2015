React = require("react")
Swipe = require("react-swipe")

module.exports = React.createClass
  swipe: -> @refs.swipe?.swipe
  
  withinImageLoadingRange: (src, index) ->
    currentPos = if @swipe() then @swipe().getPos() else 0
    numSlides = if @swipe() then @swipe().getNumSlides() else 0
    if Math.abs(currentPos-index) < 2 or (currentPos == (numSlides-1) and index == 0) or (currentPos == 0 and index == (numSlides-1))
      true
  handleSlideChange: (currentIndex) ->
    @setState 
      currentIndex: currentIndex
  render: ->
    <Swipe ref="swipe" callback={@handleSlideChange} {... @props} >
      {
        @props.children.map (child, index) =>
          newProps = {key: index, style: {minHeight: 10}}
          if !@withinImageLoadingRange(child.props.src, index)
            newProps.src = "/images/blank.png"
          React.addons.cloneWithProps(child, newProps)
      }
    </Swipe>