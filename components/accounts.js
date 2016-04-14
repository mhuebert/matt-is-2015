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
        }, ()=>{if(this.refs[`${name}:email`]){this.refs[`${name}:email`].getDOMNode().focus()}})
      }
  },
  signIn: function(e) {
    e.preventDefault()
    var currentUser ={
        email: this.refs["signIn:email"].getDOMNode().value,
        password: this.refs["signIn:password"].getDOMNode().value
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
      email: this.refs["register:email"].getDOMNode().value,
      password: this.refs["register:password"].getDOMNode().value
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
    var inputStyle = {padding:"4px 7px"}
    return (<div className="hiddenx">
              <div>
                <a className={cx({hidden: !this.state.currentUser})} href="javascript:void(0)" onClick={this.setTab("profile")}>{this.state.currentUser ? this.state.currentUser.email : ""}</a>
                <a className={cx({hidden: this.state.currentUser})} href="javascript:void(0)" onClick={this.setTab("register")}>Register</a>
                <a className={cx({hidden: this.state.currentUser})} href="javascript:void(0)" onClick={this.setTab("signIn")}>Sign In</a>
              </div>
        
              <div className={cx({"accounts-dropdown": true, hidden: !this.state.dropdownActive})}>
        
                <a href="javascript:void(0)" className="close-x" onClick={this.closeDropdown}>&times;</a>
        
                <div className={cx({hidden: this.state.activeTab !== "signIn"})}>
                  <form onSubmit={this.signIn}>
                    <input style={inputStyle} ref="signIn:email" placeholder="Email Address" type="text" /><br/>
                    <input style={inputStyle} ref="signIn:password" placeholder="Password" type="password" /><br/>
                    <input type="submit" value="Sign In" />
                  </form>
                </div>
        
                <div className={cx({hidden: (this.state.activeTab != "logOut") })}>
                  Log Out
                </div>
        
                <div className={cx({hidden:this.state.activeTab != "register"})}>
                  <form onSubmit={this.register}>
                    <input ref="register:email" type="text" /><br/>
                    <input ref="register:password" type="password" /><br/>
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