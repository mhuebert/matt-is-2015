var React = require("react")
var marked = require("marked")
var superagent = require("superagent")
var Router = require("react-router")
var {Link} = Router 
var _ = require('lodash')
var cx =require("react/lib/cx")

function slugify(text) {
  return text.toString().toLowerCase()
    .replace(/\s+/g, '-')      
    .replace(/[^\w\-]+/g, '')  
    .replace(/\-\-+/g, '-')    
    .replace(/^-+/, '')        
    .replace(/-+$/, '')
}

var Markdown = React.createClass({
  render: function() {
      var html = marked(this.props.children)
      return <div {... _(this.props).omit("children").value()} dangerouslySetInnerHTML={{__html: html}} ></div>
  }})

var posts = [ "Trying to Matter",
          "Kurt Cobain on Time",
          "Rewrite a Rant",
          "Introducing BrainTripping",
          "Introducing Hacking Health",
          "Introducing Overlap.me",
          "The Trudge"
        ]



export var Index = React.createClass({
  render: () => {
    return <div >
    <h3 ><Link to="/writing">Writing</Link></h3>
    <ul className="writing-index paper-shadow blue-links">
    {
      posts.map((post)=>{
        var slug = slugify(post)
        return <li key={slug} ><Link to={"/writing/"+slug} >{post}</Link></li>
        })
    }
    </ul>
    </div>
  }
})

export var Post = React.createClass({
  mixins: [Router.State],
  statics: {
    fetchData: (state, callback) => {
      var prefix = state.serverAddress || ""
      var url = prefix+`/posts/${state.params.slug}.md`
      superagent.get(url, (data, textStatus, xhr) => {
        callback({
          slug: state.params.slug,
          body: data.text
          })
        })
    }
  },
  componentDidMount: function() {

    if (this.getParams().slug === this.getProp("slug")) {
      return
    }
    Post.fetchData({params: this.getParams()}, (data)=>{
      this.setState({writingPost: data})
    })
  },
  getInitialState: function(){
    return {}
  },
  isLoading: function(){
    return (this.getParams().slug !== this.getProp("slug")) ? true : false
  },
  getProp: function(attribute){
    return this.state.writingPost ? this.state.writingPost[attribute] : (this.props.writingPost ? this.props.writingPost[attribute] : null)
  },
  render: function(){
      return <div >
        <h3 ><Link to="/writing">Writing</Link></h3>
        <p className={cx({hidden: !this.isLoading(), "align-center": true})}>
          <img style={{marginTop: 20, opacity: 0.3}} src="/images/loader.gif" />
        </p>
        <div className={cx({hidden: this.isLoading(), paper: true, thick: true})}>
        
        <Markdown className="blue-links">
          {this.getProp("body") || "Loading..."}
        </Markdown>
        </div>
      </div>
  }

  })


    