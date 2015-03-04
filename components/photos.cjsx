React = require("react")

module.exports = React.createClass
  getInitialState: -> 
    height: 300
    width: 622
    position: 0
    total: 16
  componentDidMount: ->
    @setState
      width: @refs.slider.getDOMNode().getBoundingClientRect().width
  handleFirstImageLoaded: (e) ->
    @setState height: @refs.firstImage.getDOMNode().height
  move: (positions) ->
    =>
      if @state.position == @state.total and positions == 1
        newState = position: 0
      if @state.position == 0 and positions == -1
        newState = position: @state.total
      @setState newState || position: @state.position + positions
  render: ->
    innerSliderStyle = 
      height: @state.height
      transform: "translate3d(#{parseInt -(@state.position * @state.width)}px, 0, 0)" 
    <div>
    <div style={{height: @state.height}} className="image-slider" ref="slider" >
      <div onClick={@move(1)} style={innerSliderStyle} className="inner-slider">
        <img style={{width: @state.width}} ref="firstImage" onLoad={@handleFirstImageLoaded} src='/photography/bg_sky_only.jpg' />
        <img style={{width: @state.width}} src='/photography/banana.jpg' />
        <img style={{width: @state.width}} src='/photography/Guatemala-002.jpg' />
        <img style={{width: @state.width}} src='/photography/Guatemala-006.jpg' />
        <img style={{width: @state.width}} src='/photography/fire.jpg' />
        <img style={{width: @state.width}} src='/photography/plane.jpg' />
        <img style={{width: @state.width}} src='/photography/kids.jpg' />
        <img style={{width: @state.width}} src='/photography/snowbird.jpg' />
        <img style={{width: @state.width}} src='/photography/moonvalley.jpg' />
        <img style={{width: @state.width}} src='/photography/baby.jpg' />
        <img style={{width: @state.width}} src='/photography/bird.jpg' />
        <img style={{width: @state.width}} src='/photography/waves.jpg' />
        <img style={{width: @state.width}} src='/photography/epp.jpg' />
        <img style={{width: @state.width}} src='/photography/Victoria-003.jpg' />
        <img style={{width: @state.width}} src='/photography/cheryl.jpg' />
        <img style={{width: @state.width}} src='/photography/flower.jpg' />
        <img style={{width: @state.width}} src='/photography/matt-epp.jpg' />
      </div>
    </div>
    <div className="slider-nav">
      <span style={float: "right" } onClick={@move(1)} className="slider-move icon-uniE720" />
      <span style={float: "left" } onClick={@move(-1)} className="slider-move icon-uniE71F" />
    </div>
    </div>