import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "displayed", "btn" ]
  // connect() {
  //   console.log("Hello from our first Stimulus controller")
  // }
  display(event){
      event.preventDefault()
      this.btnTarget.innerHTML = this.btnTarget.innerHTML === "more info" ? "close" : "more info";
      this.displayedTarget.classList.toggle("d-none")
     }
}
