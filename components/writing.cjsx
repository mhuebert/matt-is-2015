React = require("react")
marked = require("marked")
r = require("superagent")
{Link} = Router = require("react-router")

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
    <div dangerouslySetInnerHTML={{__html: html}} ></div>

posts = [ "Trying to Matter"
          "Kurt Cobain on Time"
          "Rewrite a Rant"
          "The Trudge"
        ]



@Index = React.createClass
  render: ->
    <ul className="writing-index paper-shadow">
    {
      posts.map (post) -> 
        slug = slugify(post)
        <li key={slug} ><Link to={"/writing/"+slug} >{post}</Link></li>
    }
    </ul>

@Post = React.createClass
  mixins: [Router.State]
  getInitialState: -> {}
  componentDidMount: ->
    r.get "/posts/#{@getParams().slug}.md", (data, textStatus, xhr) =>
      @setState markdown: data.text
  render: ->
    <div >
    <h3 ><Link to="/writing">Writing</Link></h3>
    <div className="paper thick">
    <Markdown>
      {@state.markdown || "Loading..."}
    </Markdown>
    </div>
    </div>
    