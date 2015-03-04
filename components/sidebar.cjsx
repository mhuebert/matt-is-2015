React = require("react")
{Link} = require("react-router")

module.exports = React.createClass
  render: ->
    <div>
      <div className="paper text-small" >
        <h2><Link to="/">Matt Huebert</Link></h2>
        <p>
          Hey—welcome to my corner of the web. I’m a designer and programmer with a special interest in creative, cross-field collaboration.
        </p>
        <hr />
        <h3>Communication</h3>
        <p>
          <span className="tag-noclick">Writing</span>
          <span className="tag-noclick">Design</span>
        </p>
        <hr />
        <h3>Tech</h3>
        <p>
          <span className="tag-noclick">Javascript</span>
          <span className="tag-noclick">React.js</span>
          <span className="tag-noclick">Firebase</span>
        </p>
        <hr />
        <h3>History</h3>
        <p>
          <em>2015</em><br/>
          <em>Relocation:</em> Berlin.
        </p>
        <p>
          <em>2014</em><br/>
          <em>Laboratory:</em> <a href="http://www.hackerschool.com">Hacker School</a>.
        </p>
        <p>
          <em>2013</em><br/>
          <em>Joined the faculty:</em> <a href="http://www.banffcentre.ca">The Banff Centre</a>.
        </p>
        <p>
          <em>2012</em><br/>
          <em>Shipped:</em> <a href="http://www.braintripping.com">BrainTripping</a>.
        </p>
        <p>
          <em>2011</em><br/>
          <em>Shipped:</em> <a href="http://www.overlap.me">Overlap.me</a>.
        </p>
        <p>
          <em>2007</em><br/>
          <em>Co-founded:</em> <a href="http://www.bodo.ca">Bodo</a>.
        </p>
      </div>
      <img className="paper-shadow subtle-corner" src="/images/matt-huebert-300px.jpg" />
    </div>