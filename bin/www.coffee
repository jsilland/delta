debug = require('debug')('peregrine')
app = require('../app')

app.set('port', process.env.PORT || 1337)

server = app.listen(app.get('port'), () ->
  debug('Express server listening on port ' + server.address().port);
)
