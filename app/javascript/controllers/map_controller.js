import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

export default class extends Controller {
  static values = {
    iconUrl: String,
    iconRetinaUrl: String,
    shadowUrl: String,
    sightings: Array,
  }

  connect() {
    delete L.Icon.Default.prototype._getIconUrl

    L.Icon.Default.mergeOptions({
      iconRetinaUrl: this.iconRetinaUrlValue,
      iconUrl: this.iconUrlValue,
      shadowUrl: this.shadowUrlValue,
    })

    const uruguayBounds = [
      [-37.0, -61.0], // Southwest corner
      [-28.0, -50.0], // Northeast corner
    ]

    const map = L.map(this.element, {
      center: [-32.5228, -55.7658],
      zoom: 7,
      maxBounds: uruguayBounds,
      maxBoundsViscosity: 1.0,
      minZoom: 7,
      maxZoom: 15,
    })

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: '&copy; OpenStreetMap contributors',
    }).addTo(map)

    L.marker([-34.9011, -56.1645])
      .addTo(map)
      .bindPopup("Montevideo")
      .openPopup()

    map.on("click", (e) => {
      const { lat, lng } = e.latlng
      const url = `/sightings/new?lat=${lat}&lng=${lng}`
      window.location.href = url
    })

    this.sightingsValue.forEach((sighting) => {
          if (sighting.lat && sighting.lng) {
            L.marker([sighting.lat, sighting.lng])
              .addTo(map)
              .bindPopup(`${sighting.description || "Sin descripción"}`)
          }
        })
  }
}
