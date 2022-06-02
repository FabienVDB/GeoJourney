import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  initialize() {
    this.baseUrl = "https://api.mapbox.com/directions-matrix/v1/mapbox/driving/";
    this.apiKey = "pk.eyJ1IjoiZmFiaWVudmRiIiwiYSI6ImNsMzJ2NXNvbTAxaGYzanA2dG93dGFoajUifQ.7Ytq_kjops26CIM84GI6mQ";
  }
  connect() {
    this.#getMatrix();
  }

  #getMatrix() {
    // let origin = this.element.dataset.origin;
    // let destination = this.element.dataset.destination;
    const source0 = "?&sources=0"
    let url = this.baseUrl +"05.71,46.19;06.81,46.49;07.00,46.18"+source0+ "?&access_token=" + this.apiKey;
    fetch(url)
      .then(response => response.json())
      .then(data => {
        //this.element.innerHTML = data.durations[0][1];
        console.log(data.durations[0][2]/3600.00)
      });
  }
}
// 05.71,46.19;  06.81,46.49;  07.00,46.18
