import { Controller } from "@hotwired/stimulus"
import L from "leaflet"
import { LocateControl } from "leaflet.locatecontrol";
import "@geoman-io/leaflet-geoman-free"

export default class extends Controller {
  static values = {
    iconUrl: String,
    iconRetinaUrl: String,
    shadowUrl: String,
    paths: Array,
    points: Array,
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
      drawMarker: true,
      drawPolygon: false,
      drawPolyline: true,
      drawCircle: false,
      drawCircleMarker: false,
      drawRectangle: false,
      drawText: false,
      editMode: false,
      editControls: false,
      cutPolygon: false,
      removalMode: false,
      rotateMode: false,
      showCompass: false,
    });

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: '&copy; OpenStreetMap contributors',
    }).addTo(map)

    // Handle the creation of sightings
    map.on("pm:create", (shape) => {
      if (shape.shape === 'Marker') {
        const { lat, lng } = shape.marker._latlng;
        const url = `/point_sightings/new?lat=${lat}&lng=${lng}`;
        window.location.href = url
      } else if (shape.shape === 'Line') {
        const latlngs = shape.layer.getLatLngs();
        const url = `/path_sightings/new?path=${JSON.stringify(latlngs)}`;
        window.location.href = url
      };

      map.pm.disableDraw();
    });

    // Render path sightings
    this.pathsValue.forEach((sighting) => {
      const polyline = L.polyline(sighting.path, { color: 'blue' }).addTo(map)

      polyline.on('click', () => {
        Turbo.visit(sighting.url, { frame: 'sighting' })
      })
    })

    // render point sightings
    this.pointsValue.forEach((sighting) => {
      const marker = L.marker([sighting.lat, sighting.lng]).addTo(map)

      marker.on('click', () => {
        Turbo.visit(sighting.url, { frame: 'sighting' })
      })
    })
  }
}
