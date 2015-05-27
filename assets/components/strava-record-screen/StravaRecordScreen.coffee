StravaRecordScreen = Polymer({
  is: 'strava-record-screen'
  
  properties:
    googlemapsapikey: String
    recording:
      type: Boolean
      value: false
      notify: true
      observer: 'recordingChanged'
    readytorecord: 
      type: Boolean
      value: false
    speed:
      type: Number
      value: 0
    distance:
      type: Number
      value: 0
    elapsedtime:
      type: Number
      value: 0
    lastKnownPosition:
      type: Object
      value: ->
        {}
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
    @recordedPositions = []
    @buffer = []
    mapElement = document.querySelector('google-map')
    @mapMarker = document.querySelector('google-map-marker')
    mapElement.addEventListener('google-map-ready',
      (event) =>
        @map = mapElement.map
        @polyline = new google.maps.Polyline(
          strokeColor: '#346CF1'
          strokeOpacity: 1.0
          strokeWeight: 8)
        @polyline.setMap(@map)
        @startWatchingPosition()
    )
  
  startWatchingPosition: ->
    @watchId = navigator.geolocation.watchPosition(
        (position) => @updatePosition(position),
        (error) => @positionUpdateError(error),
        {enableHighAccuracy: true, timeout: 5000, maximumAge: 0}
    )
  
  recordingChanged: (newValue) ->
    if newValue
      @$['finish-button'].setAttribute('enabled', 'true')
      @recordingTimer = setInterval(
          => @updateTime(),
          500
      )
    else
      clearInterval(@recordingTimer)
  
  updateTime: ->
    @elapsedtime += .5
  
  detached: ->
    navigator.geolocation.clearWatch(@watchId)  
  
  positionUpdateError: (error) ->
    console.warn("Error updating position (#{error.code}): #{error.message}")
  
  updatePosition: (position) ->
    @lastKnownPosition = position
    @updateBuffer(position)
    @updateMap(position)
    if @recording
      @updateDistance()
      @recordedPositions.push(position)
      @updatePolyline(position)
  
  updateMap: (position) ->
    @map.latitude = position.coords.latitude
    @map.longitude = position.coords.longitude
    @mapMarker.latitude = position.coords.latitude
    @mapMarker.longitude = position.coords.longitude
    
  updatePolyline: (position) ->
    @polyline.getPath().push(
        new google.maps.LatLng(position.coords.latitude, position.coords.longitude))
  
  updateBuffer: (position) ->
    @buffer.push(position)
    if @buffer.length > 4
      @buffer.shift
    @speed = position.coords.speed
    @updateReadyToRecord()

  updateDistance: ->
    lastTwoPositions = @buffer.slice(-2)
    @distance += @distanceBetween(lastTwoPoints[0].coords, lastTwoPoints[1].coords)

  distanceBetween: (first, second) ->
    earthRadius = 6371
    latitudeDifference = @toRadians(second.latitude - first.latitude)
    longitudeDifferece = @toRadians(second.longitude - first.longitude) 
    a = Math.sin(latitudeDifference / 2) * Math.sin(latitudeDifference / 2) +
        Math.cos(@toRadians(first.latitude)) * Math.cos(@toRadians(second.latitude)) * 
        Math.sin(longitudeDifferece / 2) * Math.sin(longitudeDifference / 2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    earthRadius * c
  
  toRadians: (degrees) ->
    degrees * (Math.PI / 180)
    
  updateReadyToRecord: ->
    if !@recording && @buffer.length > 4
      found = @buffer.some(
        (position) ->
          position.coords.accuracy > 5
      )
      @readytorecord = !found
})