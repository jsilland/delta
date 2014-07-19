root = window
root.Soliton ||= {}

Soliton.module = (pkg) ->
  packageMembers = pkg.split('.')
  level = root
  jQuery.each(packageMembers, (index, value) ->
    level[value] = level[value] ? { }
    level = level[value]
  )