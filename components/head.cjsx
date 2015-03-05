
React = require("react")

module.exports = React.createClass
    render: ->
        <head>
            <title >{this.props.title}</title>
            <meta name='description' content={this.props.description} />
            <meta charSet="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link href='http://fonts.googleapis.com/css?family=Vollkorn:400italic,700italic,400,700' rel='stylesheet' type='text/css' />
            <link rel="stylesheet" type="text/css" href="/app.css" /> 
            <script src="/app.js"></script>
        </head>