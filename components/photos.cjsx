React = require("react")
Slider = require("react-slick")

module.exports = React.createClass
  handleFirstImageLoaded: ->

  render: ->
    settings = 
      dots: true
      infinite: true
      speed: 500
      slidesToShow: 1
      slidesToScroll: 1
      adaptiveHeight: true
      draggable: true
      arrows: true
      dotsClass: "hide-on-mobiles slick-dots"
    <Slider ref="slider" {... settings}>
      <img onLoad={@handleFirstImageLoaded} src='/photography/bg_sky_only.jpg' />
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
