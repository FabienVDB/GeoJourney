import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ['latitude', 'longitude']

  connect() {
    console.log('hello from geolocation controller connect')
  }

  async getCurrentCoords(event) {
    event.preventDefault();
    console.log('hello from geolocation controller filterByCurrentPosition')
    const position = await this.#getCurrentPosition();
    console.log(position)
    this.latitudeTarget.value = position.coords.latitude
    this.longitudeTarget.value = position.coords.longitude

  }

  #getCurrentPosition(options = {}) {
    return new Promise((accept, reject) => {
      navigator.geolocation.getCurrentPosition(accept, reject, options);
    });
  }

}
