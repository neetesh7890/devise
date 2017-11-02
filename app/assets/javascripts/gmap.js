function gmap_show(company) {
  if ((company.lat == null) || (company.lng == null) ) {    // validation check if coordinates are there
    return 0;
  }

  handler = Gmaps.build('Google');    // map init
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers([    // put marker method
      {
        "lat": company.lat,    // coordinates from parameter company
        "lng": company.lng,
        "picture": {    // setup marker icon
          "url": 'http://bounceworld.co.za/bounceworld/wp-content/uploads/2015/10/map_marker.png',
          "width":  32,
          "height": 32
        },
        "infowindow": "<b>" + company.name + "</b> " + company.address + ", " + company.postal_code + " " + company.city
      }
    ]);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
    handler.getMap().setZoom(12);    // set the default zoom of the map
  });
}