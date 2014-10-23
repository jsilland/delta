Soliton.module 'Soliton.Cotton.Activity'

class Soliton.Cotton.Activity.FullScreenActivityView extends Backbone.View
  
  el: '#full-screen'
  
  render: ->
    style = [
      {
        stylers: [
            { lightness: "-10" }
        ]
      }, {
        featureType: "poi",
        stylers: [
            { visibility: "off" }
        ]
      }, {
        featureType: "transit",
        stylers: [
            { visibility: "off" }
        ]
      }, {
        featureType: "road",
        stylers: [
            { lightness: "50" },
            { visibility: "on" }
        ]
      }, {
        featureType: "landscape",
        stylers: [
            { lightness: "50" }
        ]
      }
    ]
    
    options =
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      disableDefaultUI: true
    
    decodedSummaryPolyline = google.maps.geometry.encoding.decodePath(@model.get('map').summary_polyline)
    bounds = new google.maps.LatLngBounds();
    for coordinate in decodedSummaryPolyline 
      bounds.extend(coordinate)
    
    summaryPolyline = new google.maps.Polyline(
      path: decodedSummaryPolyline
      strokeColor: '#FF0000'
      strokeOpacity: .7
      strokeWeight: 4
    )
    
    map = new google.maps.Map($('#full-screen')[0], options)
    map.fitBounds(bounds);
    map.setOptions(styles: style)
    summaryPolyline.setMap(map)

    new Soliton.Cotton.Models.CurrentAthlete().fetch(
      reset: true
      success: (model, response, options) =>
        if model.get('id') == @model.get('athlete').id
          new Soliton.Cotton.Models.LatLngStream(id: @model.get('id')).fetch(
            reset: true
            success: (model, response, options) ->
              fullPolyline = new google.maps.Polyline(
                path: model.get('data').map((item) -> new google.maps.LatLng(item[0], item[1]))
                strokeColor: '#FF0000'
                strokeOpacity: .7
                strokeWeight: 4
              )
              summaryPolyline.setMap(null)
              fullPolyline.setMap(map);
          )
    )
      
    @renderTemplate(activity: @model, 'templates/activity/full_screen_activity')
