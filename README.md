# Peregrine

Peregrine is a modern, mobile-friendly web application for Strava.

## Installation

Peregrine uses Node, Bower and Grunt as a development toolchain – make sure you have them installed on your system:

```sh
brew install node
npm install -g bower
npm install grunt
```

After cloning this repository, run

```sh
git submodule update
git submodule pull
bower install
npm install
```

## Provisioning a Strava API key

Provision an application from [Strava's developers website](https://www.strava.com/developers). Once you have a client identifier and a secret, you need to set it in the configuration: `config/strava_api.coffee`:

```coffee
STRAVA_API = strava_api:
  client_id: <your_client_id>
  client_secret: <your_client_secret>

module.exports = STRAVA_API
```

## Provisioning a Google Maps key

The key shipping in the code will work for moderate amounts of traffic coming from `localhost`. If you intend to deploy Peregrine in a real user-facing environment, you will need to provision your own key and configure it in `config/google_maps.coffee`

## Running

Invoking the following command compiles all the CoffeeScript code and copies all the assets in the expected directory, then boots a Node server.

```sh
grunt run
```

Use `grunt --help` or inspect the `Gruntfile` to find other commands.

## Endpoints

- `/connect`: login screen — prompts the user to authorize the application to access the Strava API
- `/record`: record screen
- `/strava/*`: forwards a request to the Strava API, e.g. `GET /strava/athletes/136697` will return the data about that particular athlete.

## License
Copyright (c) 2015 Julien Silland  
Licensed under the MIT license.
