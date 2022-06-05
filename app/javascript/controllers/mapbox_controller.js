import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  }

  initialize() {
    this.baseUrl = "https://api.mapbox.com/directions/v5/mapbox/driving";
    this.apiKey = "pk.eyJ1IjoiZmFiaWVudmRiIiwiYSI6ImNsMzJ2NXNvbTAxaGYzanA2dG93dGFoajUifQ.7Ytq_kjops26CIM84GI6mQ";
  }

  async connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/satellite-streets-v11"
    })

    // this.itineraries = this.#reconstructItineraries(JSON.parse(this.data.get("itineraries")))
    this.itineraries = JSON.parse(this.data.get("itineraries"))
    await this.#displayRoutes(this.itineraries)
    this.#fitMapToItineraries(this.itineraries)

    this.#addFirstSiteMarkersToMap(this.itineraries)
  }


  // #reconstructItineraries(itineraries) {
  //   const itineraries_coords = itineraries.map(i => i.sites.sort((s1, s2) => s1.stage - s2.stage).map(s => [s.lng, s.lat] ))
  //   return itineraries.map((itinerary, index) => {
  //     return {name: itinerary.name,
  //             summary: itinerary.summary,
  //             info_window: itinerary.info_window,
  //             image_url: itinerary.image_url,
  //             coords: itineraries_coords[index]}
  //   });
  // }

  async #displayRoutes(itineraries) {
    for (const itinerary of itineraries) {
      const route = await this.#fetchRoutesGeometries(itinerary)
      this.map.on('load', () => {this.#addLineSource(`${itinerary.name}Route`, route); this.#addLayer(`${itinerary.name}Route`)})
    }
  }

  #buildURL(itinerary) {
    const coordsString = itinerary.coords.join(';')
    return `${this.baseUrl}/${coordsString}?geometries=geojson&access_token=${this.apiKey}`
  }

  #addFirstSiteMarkersToMap(itineraries) {
    itineraries.forEach((itinerary) => {
      const popup = new mapboxgl.Popup().setHTML(itinerary.info_window)


      const customMarker = document.createElement("div")
      customMarker.className = "custom-marker"
      customMarker.style.backgroundImage = `url('${itinerary.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "25px"
      customMarker.style.height = "25px"

      new mapboxgl.Marker(customMarker)
        .setLngLat(itinerary.coords[0])
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  // #fitMapToMarkers() {
  //   const bounds = new mapboxgl.LngLatBounds()
  //   this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  //   this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  // }

  // #addMarkersToMap() {
  //   this.markersValue.forEach((marker) => {
  //     const popup = new mapboxgl.Popup().setHTML(marker.info_window) // add this
  //     new mapboxgl.Marker()
  //       .setLngLat([ marker.lng, marker.lat ])
  //       .setPopup(popup) // add this
  //       .addTo(this.map)
  //   });

  #fitMapToItineraries(itineraries) {
    const bounds = new mapboxgl.LngLatBounds()
    itineraries.forEach(itinerary => {
      itinerary.coords.forEach(siteCoords => {
        bounds.extend(siteCoords)
      });
    })
    this.map.fitBounds(bounds, { padding: 50, maxZoom: 15, duration: 0 })
  }

  async #fetchRoutesGeometries(itinerary) {
    const mapboxDirectionUrl = this.#buildURL(itinerary)
    const response = await fetch(mapboxDirectionUrl);
    const data = await response.json();
    return data.routes[0].geometry.coordinates;
  }


  #addLineSource(line_name, line_coords){
    this.map.addSource(line_name, {
              'type': 'geojson',
              'data': {
              'type': 'Feature',
              'properties': {},
              'geometry': {
                'type': 'LineString',
                'coordinates': line_coords
              }
              }
    });
  }

  #addLayer(line_name){
    this.map.addLayer({
              'id': line_name,
              'type': 'line',
              'source': line_name,
              'layout': {
                'line-join': 'round',
                'line-cap': 'round'
              },
              'paint': {
                'line-color': '#1434A4',
                'line-width': 8
              }
      });
  }

}
