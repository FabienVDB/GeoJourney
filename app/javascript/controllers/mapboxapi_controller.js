import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    // itineraries: Array
  }

  static targets = ["", ""]

  initialize() {
    this.baseUrl = "https://api.mapbox.com/directions/v5/mapbox/driving";
  }

  async connect() {
    this.itineraries = JSON.parse(this.data.get("itineraries"))
    this.itinerariesRoutes = await this.#fetchItinerariesRoutes(this.itineraries)
  }

  getItinerariesRoutes() {
    return this.itinerariesRoutes
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

}
