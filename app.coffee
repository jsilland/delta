express = require('express')
path = require('path')
favicon = require('static-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

index = require('./routes/index')
strava = require('./routes/strava')

app = express()

# view engine setup
app.set('views', path.join(process.cwd(), 'views'))
app.set('view engine', 'jade')

app.use(favicon())
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded())
app.use(cookieParser())
app.use('/assets', express.static(path.join(process.cwd(), 'bower_components')))
app.use('/assets/cotton/js', express.static(path.join(process.cwd(), 'build/assets/cotton')))
app.use('/assets/cotton/css', express.static(path.join(process.cwd(), 'assets/cotton/css')))
app.use('/assets/cotton/js/templates', express.static(path.join(process.cwd(), 'build/hamlc/assets/templates')))

app.use('/', index)
app.use('/strava', strava)

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
