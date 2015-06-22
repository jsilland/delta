express = require('express')
httpProxy = require('http-proxy')
http = require('http')
request = require('request')

router = express.Router()

router.get('/*', (req, res) ->
  request.get(proxiedUrl(req),
    headers:
      'Authorization': "Bearer #{req.cookies.strava_access_token}"
    proxyServerResponse(res)
  )
)

router.post('/*', (req, res) ->
  request.post(createProxiedRequest(req), proxyServerResponse(res))
)

router.put('/*', (req, res) ->
  request.put(createProxiedRequest(req), proxyServerResponse(res))
)

proxiedUrl = (req) ->
  params = []
  query = ''
  for param, value of req.query
    params.push("#{param}=#{encodeURIComponent(value)}")
  if !!params.length
    query = "?#{params.join('&')}"
  url = "https://www.strava.com/api/v3#{req.path}#{query}"
  console.log("Forwarding Strava API request: #{url}, token: #{req.cookies.strava_access_token}}")
  url

createProxiedRequest = (req) ->
  proxiedRequest =
    url: proxiedUrl(req)
    headers:
      'Authorization': "Bearer #{req.cookies.strava_access_token}"
      'Content-Type': req.get('content-type')
  
  if req.is('json')
    proxiedRequest['json'] = true
    proxiedRequest['body'] = JSON.stringify(req.body)
  else
    proxiedRequest['formData'] = req.body
  
  proxiedRequest

proxyServerResponse = (clientResponse) ->
  (error, response, body) ->
    if response.statusCode == 401
      clientResponse.clearCookie('strava_access_token')
      clientResponse.redirect('/')
    else
      clientResponse.set('Content-Type', response.headers['content-type']);
      clientResponse.send(response.statusCode, body)

module.exports = router
