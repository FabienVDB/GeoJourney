import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "cardcontainer", "bouton" ]
  // connect() {
  //   console.log("Hello from our first Stimulus controller")
  // }
  display(event){
    console.log(this.boutonTarget)
      event.preventDefault()
      if (this.boutonTarget.dataset.state === "closed") {
        console.log("closed");
        this.boutonTarget.dataset.state = "opened"
        this.boutonTarget.querySelector(".fa-arrow-down").classList.add("d-none")
        this.boutonTarget.querySelector(".fa-arrow-up").classList.remove("d-none")
      } else {
        this.boutonTarget.dataset.state = "closed"
        this.boutonTarget.querySelector(".fa-arrow-up").classList.add("d-none")
        this.boutonTarget.querySelector(".fa-arrow-down").classList.remove("d-none")
      }

      this.cardcontainerTarget.classList.toggle("d-none")

    }
}
