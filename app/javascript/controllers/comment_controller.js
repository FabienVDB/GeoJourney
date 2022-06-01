import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "displayed" ]
  // connect() {
  //   console.log("Hello from our first Stimulus controller")
  // }
  display(event){
      event.preventDefault()
      this.displayedTarget.classList.toggle("d-none")
    }
}
