import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "btn", "mapcontainer", "cardscontainer" ]
  // connect() {
  //   console.log("Hello from our first Stimulus controller")
  // }
  display(event){
      event.preventDefault()
      this.btnTarget.innerHTML = this.btnTarget.innerHTML === "Map" ? "List" : "Map";
      this.#toggleScroll()
      this.mapcontainerTarget.classList.toggle("d-none")
      this.cardscontainerTarget.classList.toggle("d-none")
    }

  #toggleScroll() {
      document.body.classList.toggle("stop-scrolling");
  }

}
