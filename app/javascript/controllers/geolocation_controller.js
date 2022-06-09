import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"
export default class extends Controller {
  static values = { apiKey: String }
  connect() {
    console.log('hello from geolocation controller connect')
  }

  async filterByCurrentPosition(event) {
    event.preventDefault();
    console.log('hello from geolocation controller filterByCurrentPosition')
    const position = await this.#getCurrentPosition();
    console.log(position)
  }

  #getCurrentPosition(options = {}) {
    return new Promise((accept, reject) => {
      navigator.geolocation.getCurrentPosition(accept, reject, options);
    });
  }

}
