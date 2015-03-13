React = require("react")
cx = require("react-classset")
request = require("superagent")

module.exports = React.createClass
  getInitialState: ->
    activeTab: null
    currentUser: false
  closeDropdown: ->
    @setState dropdownActive: false
  setTab: (name) ->
    (e) =>
      e.preventDefault()
      @setState
        activeTab: name
        dropdownActive: if @state.activeTab == name and @state.dropdownActive == true then false else true

  signIn: (e) ->
    e.preventDefault()
    currentUser =
      email: @refs.signInEmail.getDOMNode().value
      password: @refs.signInPassword.getDOMNode().value
    request.post("/sign-in").send(currentUser).end (err, res) =>
      @setState 
        currentUser: res.body
        dropdownActive: if res.status == 200 then null else "signIn"
  logOut: ->
    request.post("/log-out").end (err, res) =>
      if res.status == 200
        @setState 
          currentUser: false
          dropdownActive: false
  register: (e) ->
    e.preventDefault()
    currentUser =
      email: @refs.registerEmail.getDOMNode().value
      password: @refs.registerPassword.getDOMNode().value
    request.post("/register").send(currentUser).end (err, res) =>
      @setState currentUser: res.body
  componentDidMount: ->
    request.get "/authenticated", (res) =>
      @setState currentUser: res.body
  render: ->
    dropdownLabel = if @state.currentUser then @state.currentUser.email else "Sign In" 
    <div className="hidden">
      <div>
        <a className={cx(hidden: !@state.currentUser)} href="javascript:void(0)" onClick={@setTab("profile")}>{@state.currentUser.email}</a>
        <a className={cx(hidden: @state.currentUser)} href="javascript:void(0)" onClick={@setTab("register")}>Register</a>
        <a className={cx(hidden: @state.currentUser)} href="javascript:void(0)" onClick={@setTab("signIn")}>Sign In</a>
      </div>

      <div className={cx("accounts-dropdown": true, hidden: !@state.dropdownActive)}>

        <a href="javascript:void(0)", onClick={@closeDropdown}>&times;</a>

        <div className={cx(hidden: @state.activeTab != "signIn")}>
          <form onSubmit={@signIn}>
            <input ref="signInEmail" type="text" /><br/>
            <input ref="signInPassword" type="password" /><br/>
            <input type="submit" value="Sign In" />
          </form>
        </div>

        <div className={cx(hidden: (@state.activeTab != "logOut") )}>
          Log Out
        </div>

        <div className={cx(hidden:@state.activeTab != "register")}>
          <form onSubmit={@register}>
            <input ref="registerEmail" type="text" /><br/>
            <input ref="registerPassword" type="password" /><br/>
            <input type="submit" value="Register" />
          </form>
        </div>

        <div className={cx(hidden: @state.activeTab != "resetPassword")}>
          Reset Password
        </div>

        <div className={cx(hidden: @state.activeTab != "profile")}>
          <a href="javascript:void(0)" onClick={@logOut}>Log Out</a>
        </div>
      </div>

    </div>