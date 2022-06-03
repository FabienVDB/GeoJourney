import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  dropdown(event) {
    event.preventDefault
    this.event.stopPropagation()
  }
}
