express = require('express')
path = require('path')
favicon = require('static-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

routes = require('./routes/index')

app = express()

# view engine setup
app.set('views', path.join(process.cwd(), 'views'))
app.set('view engine', 'jade')

app.use(favicon())
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded())
app.use(cookieParser())
app.use('/static', express.static(path.join(process.cwd(), 'bower_components')))
app.use('/assets/js', express.static(path.join(process.cwd(), 'build/client')))

app.use('/', routes)

# catch 404 and forward to error handler
app.use((req, res, next) ->
    err = new Error('Not Found')
    err.status = 404
    next(err)
)

# error handlers

# development error handler will print stacktrace
if (app.get('env') == 'development')
    app.use((err, req, res, next) ->
        res.status(err.status || 500)
        res.render('error', {
            message: err.message,
            error: err
        })
    )
    app.locals.pretty = true

# production error handler no stacktraces leaked to user
app.use((err, req, res, next) ->
    res.status(err.status || 500)
    res.render('error', {
        message: err.message,
        error: {}
    })
)

module.exports = app
