React = require("react/addons")
prefix = require("react-prefixr")

Slider = React.createClass
  getInitialState: -> 
    height: 300
    width: 622
    position: 0
    loaded: {0: true, 1: true}
  componentDidMount: ->
    @setSize()
    window.addEventListener('resize', this.setSize)
  componentWillUnmount: (nextProps, nextState) ->
    window.removeEventListener('resize', this.setSize)
  setSize: ->
    @setState
      width: @refs.slider.getDOMNode().getBoundingClientRect().width
    @setState
      height: @refs.slide0.getDOMNode().height
  move: (positions) ->
    (e) =>
      e?.stopPropagation()
      if @state.position == @props.children.length-1 and positions == 1
        newState = position: 0
      else if @state.position == 0 and positions == -1
        newState = position: @props.children.length-1
      else 
        newState = position: @state.position + positions
      newState.loaded = @state.loaded
      newState.loaded[@props.children.length-1] = true
      newState.loaded[newState.position + positions] = true
      @setState newState
  render: ->
    transform = "translate3d(#{parseInt -(@state.position * @state.width)}px, 0, 0)" 
    innerSliderStyle = prefix
      height: @state.height
      transform: transform
    <div>
    <div style={{height: @state.height}} className="image-slider" ref="slider" >
      <div onClick={@move(-1)} style={position: 'absolute', top: 0, left: 0, width: "25%", zIndex: 1, height: "100%", cursor: "w-resize"} />
      <div onClick={@move(1)} style={innerSliderStyle} className="inner-slider">
        {
          @props.children.map (child, i) => 
            props =
              ref: "slide#{i}"
              style:
                width: @state.width
                left: i*@state.width
              key: i
            if i == 0
              props.onLoad = @setSize
            if Math.abs(@state.position-i) > 1 and i != @props.children.length-1 and !@state.loaded[i]
              props.src = "/images/blank.png"
              props.style.height = @state.height
            React.addons.cloneWithProps child, props
        }
      </div>
    </div>
    <div className="slider-nav">
      <span style={float: "right" } onClick={@move(1)} className="slider-move icon-uniE720" />
      <span style={float: "left" }  onClick={@move(-1)} className="slider-move icon-uniE71F" />
    </div>
    </div>
module.exports = React.createClass
  render: ->
    <Slider>
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
    </Slider>