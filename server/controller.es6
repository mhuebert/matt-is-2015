

var React = require("react")
var Router = require("react-router")
var routes = require("../routes")

var koa = require('koa-router')()

function fetchData(routes, params) {
  return function(done) {
    var data = {};
    Promise.all(routes
      .filter( (route) => {
        return(route.handler.fetchData);
      })
      .map( (route) => {
        return new Promise((resolve, reject)=>{
          route.handler.fetchData(params, (d) =>{
            data[route.name] = d; 
            resolve();
          })
        })
      })
    ).then(() => {done(null, data)})
  }
}

function getHandler(url) {
  return function(done) {
    Router.run(routes, url, function(Handler, state) {
      done(null, {Handler: Handler, state: state})
    })
  }
}

function getNumber(n) {
  return function(done) {
    console.log(`returning ${n+1}`)
    done(null, n+1)
  }
}

export default function(serverAddress){

  koa.get(/.*/, function* () {

    var results = yield getHandler(this.url)
    var {Handler, state} = results
    state.serverAddress = serverAddress;
    var data = yield fetchData(state.routes, state)

    var handler = React.createElement(Handler, data)
    var markup = React.renderToString(handler)
    markup = markup + `<script> Router.run(routes, Router.HistoryLocation, function(Handler, state) {
                          return React.render(React.createElement(Handler, ${JSON.stringify(data)}), document);
                        });
                      </script>`;
    
    this.set("Content-Type", "text/html")
    this.body = markup
    });

  return koa;



}