Strava.module('Strava.Activity').ActivityView = Polymer({
  is: 'strava-activity-view'

  properties:
    googleMapsApiKey: String
    id: Number
    activity:
      type: Object
      notify: true
      observer: 'activityReceived'
    googleMapOptions:
      type: Object
      value: ->
        @_googleMapOptions()

  _googleMapOptions: ->
    disableDoubleClickZoom: true
    draggable: false
    overviewMapControl: false
    panControl: false
    rotateControl: false
    scaleControl: false
    scrollwheel: false
    streetViewControl: false
    zoomControl: false
    mapTypeControl: false
    styles: [
      {
        featureType: "road.local"
        elementType: "labels"
        stylers: [{ visibility: "off"}]
      },
      {
        featureType: "poi"
        elementType: "labels"
        stylers: [{visibility: "off"}]
      },
      {
        featureType: "landscape.man_made"
        elementType: "all"
        stylers: [{visibility: "off"}]
      },
      {
        featureType: "administrative"
        elementType: "label",
        stylers: [{visibility: "on"}]
      }
    ]

  ready: ->
    @mapElement = document.querySelector('google-map')
    @mapElement.addEventListener('google-map-ready',
      (event) =>
        @map = @mapElement.map
    )

  activityUrl: (activityId) ->
    "/strava/activities/#{activityId}"

  athleteUrl: (athleteId) ->
    "/strava/athletes/#{athleteId}"

  formatAthleteName: (athlete) ->
    if athlete?
      "#{athlete.firstname} #{athlete.lastname}"
    else
      ''

  formatDistance: (activity) ->
    if activity?
      if activity.distance > 1000 then "#{(activity.distance / 1000).toFixed(1)} km" else "#{activity.distance} m"
    else
      ''

  formatDate: (dateString) ->
    localDate = new Date(dateString)
    utcDate = new Date(localDate.getUTCFullYear(), localDate.getUTCMonth(), localDate.getUTCDate(), localDate.getUTCHours(), localDate.getUTCMinutes(), localDate.getUTCSeconds())
    formatter = new TwitterCldr.DateTimeFormatter()
    "#{formatter.format(utcDate, {format: "date", type: "medium"})} – #{formatter.format(utcDate, {format: "time", type: "short"})}"

  formatTime: (activity) ->
    if activity?
      time = activity.moving_time
      "#{@formatHours(time)}:#{@formatMinutes(time)}:#{@formatSeconds(time)}"
    else
      ''

  formatHours: (time) ->
    @pad(Math.floor(time / 3600))

  formatMinutes: (time) ->
    @pad(Math.floor((time % 3600) / 60))

  formatSeconds: (time) ->
    @pad((time % 3600) % 60)

  pad: (value) ->
    if value < 10
      "0#{value}"
    else
      "#{value}"

  activityReceived: ->
    @$['athlete-request'].url = @athleteUrl(@activity.athlete.id)
    @$['athlete-request'].generateRequest()
    if @map
      @showActivity()
    else
      @mapElement.addEventListener('google-map-ready',
        (event) =>
          @showActivity()
      )

  showActivity: ->
    coordinates = google.maps.geometry.encoding.decodePath(@activity.map.polyline)
    bounds = new google.maps.LatLngBounds()
    for coordinate in coordinates
      bounds.extend(coordinate)
    @map.fitBounds(bounds)
    new google.maps.Polyline(
      strokeColor: '#FF5854'
      strokeOpacity: 1.0
      path: coordinates
      strokeWeight: 6).setMap(@map)
})