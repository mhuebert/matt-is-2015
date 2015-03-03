React = require("react")

module.exports = React.createClass
  getInitialState: -> {}
  handleClick: -> @setState message: "Clicked"
  render: ->
    <div className="grid">
      <div className="unit whole-width" style={{minHeight: 50}}>

      </div>
      <div className="unit two-thirds">
        <div className="paper thick" onClick={@handleClick}>
          <h2>{@state.message||"About Matt"}</h2>
          <p>For six years, Matt has explored creativity and collaboration through a practice of design and computer programming while learning at some of the world’s most interesting institutions for collaborative education (<a href="http://www.hackerschool.com" >Hacker School</a>), small-team innovation (<a href="http://www.ycombinator.com" >Y Combinator</a>), and interdisciplinary development of arts and leadership (<a href="http://www.banffcentre.ca" >The Banff Centre</a>).</p>
          <p>

          Along the way, Matt co-founded <a href="http://www.hackinghealth.ca" >Hacking Health</a>, a global medical hackathon movement which pairs doctors, nurses, and other health professionals with designers, programmers, and entrepreneurs to prototype and problem-solve in healthcare; he designed and programmed <a href="http://www.braintripping.com" >BrainTripping</a>, a language model app which enables users to invent stories using the authentic vocabulary and language patterns of historical and cultural personalities; and he built <a href="http://www.sparkboard.com" >Sparkboard</a>, a software platform for managing interdisciplinary hackathons and small-team oriented and collaboration communities. Matt previously co-founded a consumer wellness retail and distribution firm, <a href="http://www.bodo.ca" >Bodo</a>.
          </p>

          <p>
            Recurring themes in Matt's work include storytelling (how do we make sense of time, space, self, and community?) and probability (how do we make concrete plans for the unexpected?). Matt has lived in Beijing, Buenos Aires, Calgary, Bogotá, Mountain View, New York, and Montréal, and currently resides in Berlin. Habits, hobbies, and fascinations include improvisational theatre, cello, meditation, and language study (French, Spanish, German). His dilettantism is buttressed by the conviction that one needn’t become an expert in a field before giving and receiving valuable contributions.
          </p>

          <p>
            Matt is an ordained member of the Spiritual Humanist clergy.
          </p>

        </div>
      </div>
      <div className="unit one-third align-center">
        <div className="paper" style={{fontSize: 14, lineHeight: "130%"}}>
          <h2>Matt Huebert</h2>
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
            <em>Relocate:</em> Berlin.
          </p>
          <p>
            <em>2014</em><br/>
            <em>Attend</em> <a href="http://www.hackerschool.com">Hacker School</a>.
          </p>
          <p>
            <em>2013</em><br/>
            <em>Join</em> <a href="http://www.banffcentre.ca">The Banff Centre</a> faculty.
          </p>
          <p>
            <em>2012</em><br/>
            <em>Ship</em> <a href="http://www.braintripping.com">BrainTripping</a>.
          </p>
          <p>
            <em>2011</em><br/>
            <em>Ship</em> <a href="http://www.overlap.me">Overlap.me</a>.
          </p>
          <p>
            <em>2007</em><br/>
            <em>Co-found</em> <a href="http://www.bodo.ca">Bodo</a>.
          </p>
        </div>
        <img className="paper-shadow subtle-corner" src="/images/matt-huebert-300px.jpg" />
      </div>
    </div>