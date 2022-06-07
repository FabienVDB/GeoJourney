import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "cardHeart" ]
  connect(){
    console.log("hello")

  }
  active(){
    console.log("active")

    console.log(this.cardHeartTarget)
    this.cardHeartTarget.classList.add("active")

  }
}
