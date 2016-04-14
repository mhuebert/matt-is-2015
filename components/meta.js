var React = require("react")
var {Link} = require("react-router")

module.exports = React.createClass({
  getInitialState: function(){return {}},
  render: function(){
    return <div>
      <h3 style={{marginTop:-5}}><Link to="/meta">Meta</Link></h3>

      <div className="paper thick" >
        <h2>{this.state.message||"About Matt"}</h2>
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
  }
})