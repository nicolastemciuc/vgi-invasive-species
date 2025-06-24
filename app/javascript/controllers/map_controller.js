import { Controller } from "@hotwired/stimulus"
import L from "leaflet"
import { LocateControl } from "leaflet.locatecontrol";
import "@geoman-io/leaflet-geoman-free"

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

    var lc = new LocateControl({flyTo: true}).addTo(map);

    lc.start();

    // add Leaflet-Geoman controls with some options to the map
    map.pm.addControls({
      position: 'topleft',
    });

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: '&copy; OpenStreetMap contributors',
    }).addTo(map)

    map.on("pm:drawstart", ({ workingLayer }) => {
      workingLayer.on("pm:snap", (e) => {
        const { lat, lng } = e.marker._latlng
        const url = `/sightings/new?lat=${lat}&lng=${lng}`
        window.location.href = url
      });
    });

    this.sightingsValue.forEach((sighting) => {
      if (sighting.lat && sighting.lng) {
        const marker = L.marker([sighting.lat, sighting.lng]).addTo(map)

        marker.on('click', () => {
          Turbo.visit(sighting.url, { frame: 'sighting' })
        })
      }
    })
  }
}
