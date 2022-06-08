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
    this.matrixBaseUrl = "https://api.mapbox.com/directions-matrix/v1/mapbox/driving";
  }

  async connect() {
    this.#createMap()
    this.itinerary = JSON.parse(this.data.get("sites"))
    console.log(this.itinerary)
    this.itineraryRoute = await this.#fetchItineraryRoute(this.itinerary)
    this.itineraryMatrix = await this.#fetchItineraryMatrix(this.itinerary)
    console.log(this.itineraryMatrix)
    this.#addSitesSource()
    this.#addSitesLayer()
    this.#displayRoute(this.itineraryRoute)
    this.#fitMapToItinerary(this.itineraryRoute)
    this.#addMarkersToMap()
    this.element.classList.add("d-none")
    // this.#zoomOnselected()

    console.log(this.#buildMatrixURL(this.itinerary))
  }

  #zoomOnselected(){
    this.map.on('click', async (e) => {
      const selectedFeatures = this.map.queryRenderedFeatures(e.point, {layers: ['circle']});
      // console.log(selectedFeatures)
      this.map.flyTo({center: selectedFeatures[0], zoom:15, pitch:45});
    })

    // this.map.on('click', 'circle', (e) => {
    //   this.map.flyTo({
    //     center: e.features[0].geometry.coordinates
    //   });
    // });
  }

  #createMap() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/fabienvdb/cl42opbkr004114p7gs9ojuyn"
    })

  }

  async #fetchItineraryRoute(itinerary) {
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

  #displayRoute(itineraryRoute) {
      this.map.on('load', () => {
        this.#addLineSource(`${itineraryRoute.name} Route`, itineraryRoute.coords);
        this.#addLayer(`${itineraryRoute.name} Route`)
      })
  }

  #addMarkersToMap() {
    this.itinerary.sites.forEach((site) => {
      const popup = new mapboxgl.Popup().setHTML(site.info_window)

      const customMarker = document.createElement("div")
      customMarker.className = "custom-marker"
      customMarker.style.backgroundImage = `url('${site.image_url}')`
      customMarker.style.backgroundSize = "contain"

      new mapboxgl.Marker(customMarker)
        .setLngLat(site.coords)
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  #fitMapToItinerary(itineraryRoute) {
    const bounds = new mapboxgl.LngLatBounds()
    itineraryRoute.coords.forEach(siteCoords => {
      bounds.extend(siteCoords)
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

  #addSitesSource() {
    const features = this.itinerary.sites.map((site) => {
      return {
        'type': 'Feature',
        'properties': {},
        'geometry': {
        'type': 'Point',
        'coordinates': site.coords
        }
      }
    });

    this.map.addSource('points', {
      'type': 'geojson',
      'data': {
        'type': 'FeatureCollection',
        'features': features
      }
    });
  }

  #addSitesLayer() {
    this.map.addLayer({
      'id': 'circle',
      'type': 'circle',
      'source': 'points',
      'paint': {
        'circle-color': '#4264fb',
        'circle-radius': 8,
        'circle-stroke-width': 2,
        'circle-stroke-color': '#ffffff'
      }
    });
  }

  async #fetchItineraryMatrix(itinerary) {
    const mapboxMatrixUrl = this.#buildMatrixURL(itinerary)
    const response = await fetch(mapboxMatrixUrl);
    const data = await response.json();
    const durations = [0];
    // console.log(data.durations.length)
    data.durations.forEach((row, index) => {
      if (index < data.durations.length - 1) {
        // console.log(index, row[index + 1]);
        durations.push(Math.round(row[index + 1] / 60))
      }
    })
    // console.log(durations)
    // return data;
    return { id: itinerary.id,
             name: itinerary.name,
             travel_times_in_minutes: durations,
             total_duration: data.durations[0][data.durations.length - 1]
    };
  }

  #buildMatrixURL(itinerary) {
    const coordsString = itinerary.coords.join(';')
    return `${this.matrixBaseUrl}/${coordsString}?&access_token=${this.apiKeyValue}`
  }

}


// this.map.addSource('points', {
//   'type': 'geojson',
//   'data': {
//   'type': 'FeatureCollection',
//   'features': [
//     {
//       'type': 'Feature',
//       'properties': {},
//       'geometry': {
//       'type': 'Point',
//       'coordinates': [-91.3952, -0.9145]
//       }
//     },
//     {
//       'type': 'Feature',
//       'properties': {},
//       'geometry': {
//       'type': 'Point',
//       'coordinates': [-90.3295, -0.6344]
//       }
//     },
//     {
//       'type': 'Feature',
//       'properties': {},
//       'geometry': {
//       'type': 'Point',
//       'coordinates': [-91.3403, 0.0164]
//       }
//     }
//   ]
//   }
// });
// }
