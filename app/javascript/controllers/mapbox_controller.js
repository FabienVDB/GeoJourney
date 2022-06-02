import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  initialize() {
    this.baseUrl = "https://api.mapbox.com/directions/v5/mapbox/driving/";
    this.apiKey = "pk.eyJ1IjoiZmFiaWVudmRiIiwiYSI6ImNsMzJ2NXNvbTAxaGYzanA2dG93dGFoajUifQ.7Ytq_kjops26CIM84GI6mQ";
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.map.on('load', () => {this.#addLineSource(); this.#drawLineSource()})

    // routes_url = "https://api.mapbox.com/directions/v5/mapbox/driving/0,45;5,40?access_token=pk.eyJ1IjoiZmFiaWVudmRiIiwiYSI6ImNsMzJ2NXNvbTAxaGYzanA2dG93dGFoajUifQ.7Ytq_kjops26CIM84GI6mQ"
    //     var coords = polyline.decode(data.routes[0].geometry);
    // var line = L.polyline(coords).addTo(mapTwo);

    // console.log(this.data.get("coordinates"))

    //this.coords = this.data.get("coordinates")

    //this.itineraries = this.data.get("itineraries")
    //console.log(this.coords)
    // console.log(typeof this.coords);
    // console.log(typeof this.markersValue);
    // console.log(this.coords)
    //console.log(typeof this.itineraries)
    // this.markers = this.coords.map((e) => e)
    // console.log(this.markers)

    this.itineraries = JSON.parse(this.data.get("coordinates"))
    this.sitesCoords = this.itineraries.map((i) => i.sites)
    this.itineraries.forEach((i) => {
      console.log(i.sites)
      const coords_arr = i.sites.map(site => {
        console.log([site.lng, site.lat])
      });
      console.log(coords_arr);
    }
    );
    // console.log(this.itineraries)
    // console.log(this.sitesCoords)
    // console.log(this.markersValue)

    // this.names = this.coords.map((e) => e.name)
    // console.log(this.names)

    // this.markers_lng = this.markersValue.map((m) => m.lng)
    // console.log(this.markers_lng)

  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  // async fetchRoutesGeometries() {
  //   const response = await fetch(`${this.baseUrl}?q=${this.inputTarget.value}&appid=${this.apiKey}&units=metric`);
  //   const data = await response.json();
  //   this.#displayResults(data);
  // }


  #addLineSource(){
    this.map.addSource('route', {
              'type': 'geojson',
              'data': {
              'type': 'Feature',
              'properties': {},
              'geometry': {
                'type': 'LineString',
                'coordinates': [
                  [-122.483696, 37.833818],
                  [-122.483482, 37.833174],
                  [-122.483396, 37.8327],
                  [-122.483568, 37.832056],
                  [-122.48404, 37.831141],
                  [-122.48404, 37.830497],
                  [-122.483482, 37.82992],
                  [-122.483568, 37.829548],
                  [-122.48507, 37.829446],
                  [-122.4861, 37.828802],
                  [-122.486958, 37.82931],
                  [-122.487001, 37.830802],
                  [-122.487516, 37.831683],
                  [-122.488031, 37.832158],
                  [-122.488889, 37.832971],
                  [-122.489876, 37.832632],
                  [-122.490434, 37.832937],
                  [-122.49125, 37.832429],
                  [-122.491636, 37.832564],
                  [-122.492237, 37.833378],
                  [-122.493782, 37.833683]
                ]
              }
              }
    });
  }

  #drawLineSource(){
    this.map.addLayer({
              'id': 'route',
              'type': 'line',
              'source': 'route',
              'layout': {
                'line-join': 'round',
                'line-cap': 'round'
              },
              'paint': {
                'line-color': '#888',
                'line-width': 8
              }
      });
  }

}
