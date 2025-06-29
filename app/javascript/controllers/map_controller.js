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
    zones: Array,
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
      drawPolygon: true,
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

    let temporaryShape = null;

    // Handle the creation of sightings
    map.on("pm:create", (shape) => {
      let url = '';
      let params = '';

      if (shape.shape === 'Marker') {
        const latlngs = shape.marker.getLatLng();
        params = `point=${encodeURIComponent(JSON.stringify(latlngs))}`;
        url = `/point_sightings/new?${params}`;
        temporaryShape = shape.marker;
      } else if (shape.shape === 'Line') {
        const latlngs = shape.layer.getLatLngs();
        params = `path=${encodeURIComponent(JSON.stringify(latlngs))}`;
        url = `/path_sightings/new?${params}`;
        temporaryShape = shape.layer;
      } else if (shape.shape === 'Polygon') {
        const latlngs = shape.layer.getLatLngs()[0];
        params = `zone=${encodeURIComponent(JSON.stringify(latlngs))}`;
        url = `/zone_sightings/new?${params}`;
        temporaryShape = shape.layer;
      }

      fetch(url, {
        headers: {
          "Accept": "text/vnd.turbo-stream.html"
        }
      })
        .then(response => response.text())
        .then(html => Turbo.renderStreamMessage(html));

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

    // render zone sightings
    this.zonesValue.forEach((sighting) => {
      const latlngs = sighting.zone.map(p => [p.lat, p.lng]);

      const polygon = L.polygon(latlngs, { color: 'green' }).addTo(map);

      polygon.on('click', () => {
        Turbo.visit(sighting.url, { frame: 'sighting' });
      });
    });

    window.addEventListener("modal:closed", () => {
      if (temporaryShape) {
        map.removeLayer(temporaryShape);
        temporaryShape = null;
      }
    });
  }
}
