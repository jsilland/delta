root = window
root.Strava ||= {}

Strava.module = (pkg) ->
  packageMembers = pkg.split('.')
  level = root
  packageMembers.forEach((value, index) ->
    level[value] = level[value] ? { }
    level = level[value]
  )
  level