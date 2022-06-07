import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "btn", "mapcontainer", "cardscontainer" ]
  // connect() {
  //   console.log("Hello from our first Stimulus controller")
  // }
  display(event){
      event.preventDefault()
      const mapBtnHTML = '<i class="fa-solid fa-map"></i> Map'
      const listBtnHTML = '<i class="fa-solid fa-list"></i> List'
      this.btnTarget.innerHTML = this.btnTarget.innerHTML ===  mapBtnHTML ? listBtnHTML : mapBtnHTML;
      this.#toggleScroll()
      this.mapcontainerTarget.classList.toggle("d-none")
      this.cardscontainerTarget.classList.toggle("d-none")
    }

  #toggleScroll() {
      document.body.classList.toggle("stop-scrolling");
  }

}
