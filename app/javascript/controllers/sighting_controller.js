import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("turbo:frame-load", () => {
      this.open()
    })
  }

  open() {
    this.element.classList.remove("translate-x-full")
  }

  close() {
    this.element.classList.add("translate-x-full")
  }
}
