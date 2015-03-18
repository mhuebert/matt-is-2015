var React = require("react");
var cx = require("react-classset");
var request = require("superagent");

module.exports = React.createClass({
  getInitialState: function(){
    return {
      activeTab: null,
      currentUser: false
    }
  },
  closeDropdown: function(){
    this.setState({dropdownActive: false})
  },
  setTab: function(name) {
    var self = this
    return (e) => {
      e.preventDefault()
      self.setState({
          activeTab: name,
          dropdownActive: (this.state.activeTab == name && this.state.dropdownActive == true) ? false : true  
        })
      }
  },
  signIn: function(e) {
    e.preventDefault()
    var currentUser ={
        email: this.refs.signInEmail.getDOMNode().value,
        password: this.refs.signInPassword.getDOMNode().value
    }
    request.post("/sign-in").send(currentUser).end((err, res) => {
      this.setState({
        currentUser: res.body,
        dropdownActive: res.status == 200 ? null : "signIn"})
    })
  },
  logOut: function() {
    request.post("/log-out").end((err, res) => {
      if (res.status == 200) {
          this.setState({
            currentUser: false,
            dropdownActive: false })
      }
    })
  },
  register: function(e) {
    e.preventDefault()
    var currentUser ={
      email: this.refs.registerEmail.getDOMNode().value,
      password: this.refs.registerPassword.getDOMNode().value
    }
    request.post("/register").send(currentUser).end((err, res) =>{
          this.setState({currentUser: res.body})
    })
  },
  componentDidMount: function() {
    request.get("/authenticated", (res) => {
      this.setState({currentUser: res.body})
      })
    },
  render: function() {
    return (<div className="hiddenx">
              <div>
                <a className={cx({hidden: !this.state.currentUser})} href="javascript:void(0)" onClick={this.setTab("profile")}>{this.state.currentUser ? this.state.currentUser.email : ""}</a>
                <a className={cx({hidden: this.state.currentUser})} href="javascript:void(0)" onClick={this.setTab("register")}>Register</a>
                <a className={cx({hidden: this.state.currentUser})} href="javascript:void(0)" onClick={this.setTab("signIn")}>Sign In</a>
              </div>
        
              <div className={cx({"accounts-dropdown": true, hidden: !this.state.dropdownActive})}>
        
                <a href="javascript:void(0)" onClick={this.closeDropdown}>&times;</a>
        
                <div className={cx({hidden: this.state.activeTab !== "signIn"})}>
                  <form onSubmit={this.signIn}>
                    <input ref="signInEmail" type="text" /><br/>
                    <input ref="signInPassword" type="password" /><br/>
                    <input type="submit" value="Sign In" />
                  </form>
                </div>
        
                <div className={cx({hidden: (this.state.activeTab != "logOut") })}>
                  Log Out
                </div>
        
                <div className={cx({hidden:this.state.activeTab != "register"})}>
                  <form onSubmit={this.register}>
                    <input ref="registerEmail" type="text" /><br/>
                    <input ref="registerPassword" type="password" /><br/>
                    <input type="submit" value="Register" />
                  </form>
                </div>
        
                <div className={cx({hidden: this.state.activeTab != "resetPassword"})}>
                  Reset Password
                </div>
        
                <div className={cx({hidden: this.state.activeTab != "profile"})}>
                  <a href="javascript:void(0)" onClick={this.logOut}>Log Out</a>
                </div>
              </div>
        
            </div>  )  ;
  }
})