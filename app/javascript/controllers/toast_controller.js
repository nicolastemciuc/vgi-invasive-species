import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const toast = this.element

    setTimeout(() => {
      toast.remove()
    }, 5000)
  }
}
