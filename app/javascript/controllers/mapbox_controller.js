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


    // routes_url = "https://api.mapbox.com/directions/v5/mapbox/driving/0,45;5,40?access_token=pk.eyJ1IjoiZmFiaWVudmRiIiwiYSI6ImNsMzJ2NXNvbTAxaGYzanA2dG93dGFoajUifQ.7Ytq_kjops26CIM84GI6mQ"
    //     var coords = polyline.decode(data.routes[0].geometry);
    // var line = L.polyline(coords).addTo(mapTwo);

    // console.log(this.data.get("coordinates"))
    this.coords = this.data.get("coordinates")
    this.itineraries = this.data.get("itineraries")
    // console.log(this.coords)
    // console.log(typeof this.coords);
    // console.log(typeof this.markersValue);
    // console.log(this.coords)
    console.log(typeof this.itineraries)
    // this.markers = this.coords.map((e) => e)
    // console.log(this.markers)
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

}
