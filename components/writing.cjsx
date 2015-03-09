React = require("react")
marked = require("marked")
r = require("superagent")
{Link} = Router = require("react-router")
_ = require('lodash')
cx =require("react/lib/cx")

slugify = (text) ->
  text.toString().toLowerCase()
    .replace(/\s+/g, '-')      
    .replace(/[^\w\-]+/g, '')  
    .replace(/\-\-+/g, '-')    
    .replace(/^-+/, '')        
    .replace(/-+$/, '')

Markdown = React.createClass
  render: ->
    html = marked(@props.children)
    <div {... _(@props).omit("children").value()} dangerouslySetInnerHTML={{__html: html}} ></div>

posts = [ "Trying to Matter"
          "Kurt Cobain on Time"
          "Rewrite a Rant"
          "Introducing BrainTripping"
          "Introducing Hacking Health"
          "Introducing Overlap.me"
          "The Trudge"
        ]



@Index = React.createClass
  render: ->
    <div >
    <h3 ><Link to="/writing">Writing</Link></h3>
    <ul className="writing-index paper-shadow blue-links">
    {
      posts.map (post) -> 
        slug = slugify(post)
        <li key={slug} ><Link to={"/writing/"+slug} >{post}</Link></li>
    }
    </ul>
    </div>

@Post = Post = React.createClass
  mixins: [Router.State]
  getInitialState: -> {}
  statics:
    fetchData: (state, callback) ->  
      prefix = state.serverAddress || ""
      url = prefix+"/posts/#{state.params.slug}.md"
      r.get url, (data, textStatus, xhr) =>
        callback
          slug: state.params.slug
          body: data.text
  componentDidMount: ->
    if @getParams().slug == (@state.writingPost?.slug || @props.writingPost?.slug)
      return
    Post.fetchData {params: @getParams()}, (data) =>
      @setState writingPost: data
  isLoading: ->
    !@state.writingPost and @getParams().slug != @props.writingPost?.slug
  render: ->
    <div >
      <h3 ><Link to="/writing">Writing</Link></h3>
      <p className={cx(hidden: !@isLoading(), "align-center": true)}>
        <img style={marginTop: 20, opacity: 0.3} src="/images/loader.gif" />
      </p>
      <div className={cx(hidden: @isLoading(), paper: true, thick: true)}>
      
      <Markdown className="blue-links">
        {@state.writingPost?.body || @props.writingPost?.body || "Loading..."}
      </Markdown>
      </div>
    </div>
    