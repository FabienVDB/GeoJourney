import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  }

  static targets = ['map']

  initialize() {
    this.baseUrl = "https://api.mapbox.com/directions/v5/mapbox/driving";
  }

  async connect() {
    this.#createMap()
    this.itineraries = JSON.parse(this.data.get("itineraries"))
    this.itinerariesRoutes = await this.#fetchItinerariesRoutes(this.itineraries)

    this.#displayRoutes(this.itinerariesRoutes)

    this.#fitMapToItineraries(this.itineraries)
    this.#addFirstSiteMarkersToMap(this.itineraries)

    this.element.classList.add("d-none")
  }

  #zoomOnselected(){
    this.map.on('click', async (e) => {
      const selectedFeatures = this.map.queryRenderedFeatures(e.point, {layers: ['maine', 'points']});
      console.log(selectedFeatures)
      this.map.flyTo({center: selectedFeatures[0], zoom:15, pitch:45});
    })
  }

  #createMap() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/fabienvdb/cl42opbkr004114p7gs9ojuyn"
    })

  }

  async #fetchItinerariesRoutes(itineraries) {
    const promises = itineraries.map(async (itinerary) => await this.#fetchItineraryRoutes(itinerary));
    return Promise.all(promises);
  }

  async #fetchItineraryRoutes(itinerary) {
    const mapboxDirectionUrl = this.#buildURL(itinerary)
    const response = await fetch(mapboxDirectionUrl);
    const data = await response.json();
    return { id: itinerary.id,
             name: itinerary.name,
             duration: data.routes[0].duration,
             coords: data.routes[0].geometry.coordinates
    };
  }

  #buildURL(itinerary) {
    const coordsString = itinerary.coords.join(';')
    return `${this.baseUrl}/${coordsString}?geometries=geojson&access_token=${this.apiKeyValue}`
  }

  #displayRoutes(itinerariesRoutes) {
    itinerariesRoutes.forEach((itineraryRoute) => {
      this.map.on('load', () => {
        this.#addLineSource(`${itineraryRoute.name} Route`, itineraryRoute.coords);
        this.#addLayer(`${itineraryRoute.name} Route`)
      })
    })
  }


  #addFirstSiteMarkersToMap(itineraries) {
    itineraries.forEach((itinerary) => {
      const popup = new mapboxgl.Popup().setHTML(itinerary.info_window)

      const customMarker = document.createElement("div")
      customMarker.className = "custom-marker"
      customMarker.style.backgroundImage = `url('${itinerary.image_url}')`
      customMarker.style.backgroundSize = "contain"

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

  #fitMapToItineraries(itinerariesRoutes) {
    const bounds = new mapboxgl.LngLatBounds()
    itinerariesRoutes.forEach(itineraryRoute => {
      itineraryRoute.coords.forEach(siteCoords => {
        bounds.extend(siteCoords)
      });
    })
    this.map.fitBounds(bounds, { padding: 50, maxZoom: 15, duration: 0 })
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
                'line-color': '#F6E3A1',
                'line-width': 6
              }
      });
  }

}
