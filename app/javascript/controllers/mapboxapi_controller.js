import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    itineraries: Array
  }

  initialize() {
    this.baseUrl = "https://api.mapbox.com/directions/v5/mapbox/driving";
    // this.apiKey = "pk.eyJ1IjoiZmFiaWVudmRiIiwiYSI6ImNsMzJ2NXNvbTAxaGYzanA2dG93dGFoajUifQ.7Ytq_kjops26CIM84GI6mQ";
    console.log('Hello from mapboxAPI#initialize')
    console.log(this.apiKeyValue)
    console.log(JSON.parse(this.data.get("itineraries")))
  }

  connect() {
    // mapboxgl.accessToken = this.apiKeyValue
    // this.itineraries = JSON.parse(this.data.get("itineraries"))
    // this.itinerariesRoutes = await this.#fetchItinerariesRoutes(this.itineraries)
    console.log('Hello from mapboxAPI#connect')
    console.log(this.apiKey)
  }

  display() {
    //console.log(this.itinerariesRoutes)
    console.log('Hello from mapboxAPI#display')
  }

  async #fetchItinerariesRoutes(itineraries) {
    itineraries.forEach(itinerary => {
      console.log(this.#fetchRoutes(itinerary))
    });
  }

  async #fetchRoutes(itinerary) {
    const mapboxDirectionUrl = this.#buildURL(itinerary)
    const response = await fetch(mapboxDirectionUrl);
    const data = await response.json();
    return { duration: data.routes[0].duration,
            coords: data.routes[0].geometry.coordinates
    };
  }

  #buildURL(itinerary) {
    const coordsString = itinerary.coords.join(';')
    return `${this.baseUrl}/${coordsString}?geometries=geojson&access_token=${this.apiKey}`
  }

}
