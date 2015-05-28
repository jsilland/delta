StravaConnectButton = Polymer({
  is: 'strava-connect-button'
  
  properties:
    clientid: Number
    host: String
    redirect: String

  created: ->
    console.log(@localName + '#' + @id + ' was created')

  ready: ->
    @$['connect-button'].addEventListener('click', => @authenticate())
    
  authenticate: ->
    exchangeUrl = encodeURIComponent("#{@host}/connect/exchange")
    redirectTo = encodeURIComponent(@redirect)
    window.location = "https://www.strava.com/oauth/authorize?approval_prompt=force&client_id=#{@clientid}&redirect_uri=#{exchangeUrl}&scope=view_private&response_type=code&state=#{redirectTo}"
})