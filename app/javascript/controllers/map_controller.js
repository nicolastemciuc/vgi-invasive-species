import { Controller } from "@hotwired/stimulus"
import L from "leaflet"
import { LocateControl } from "leaflet.locatecontrol"
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
    this.setupIcons()
    this.initializeMap()
    this.renderSightings()
    this.setupGeoman()
    this.setupEventListeners()
  }

  setupIcons() {
    delete L.Icon.Default.prototype._getIconUrl

    L.Icon.Default.mergeOptions({
      iconRetinaUrl: this.iconRetinaUrlValue,
      iconUrl: this.iconUrlValue,
      shadowUrl: this.shadowUrlValue,
    })
  }

  initializeMap() {
    const uruguayBounds = [
      [-37.0, -61.0],
      [-28.0, -50.0],
    ]

    this.map = L.map(this.element, {
      center: [-32.5228, -55.7658],
      zoom: 7,
      maxBounds: uruguayBounds,
      maxBoundsViscosity: 1.0,
      minZoom: 7,
      maxZoom: 15,
    })

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: '&copy; OpenStreetMap contributors',
    }).addTo(this.map)

    const lc = new LocateControl({ flyTo: true }).addTo(this.map)
    lc.start()
  }

  renderSightings() {
    this.pathsValue.forEach(sighting => this.addSightingToMap(sighting))
    this.pointsValue.forEach(sighting => this.addSightingToMap(sighting))
    this.zonesValue.forEach(sighting => this.addSightingToMap(sighting))
  }

  setupGeoman() {
    this.map.pm.addControls({
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
    })

    this.temporaryShape = null

    this.map.on("pm:create", (shape) => {
      let url = ''
      let params = ''

      if (shape.shape === 'Marker') {
        const latlngs = shape.marker.getLatLng()
        params = `point=${encodeURIComponent(JSON.stringify(latlngs))}`
        url = `/point_sightings/new?${params}`
        this.temporaryShape = shape.marker
      } else if (shape.shape === 'Line') {
        const latlngs = shape.layer.getLatLngs()
        params = `path=${encodeURIComponent(JSON.stringify(latlngs))}`
        url = `/path_sightings/new?${params}`
        this.temporaryShape = shape.layer
      } else if (shape.shape === 'Polygon') {
        const latlngs = shape.layer.getLatLngs()[0]
        params = `zone=${encodeURIComponent(JSON.stringify(latlngs))}`
        url = `/zone_sightings/new?${params}`
        this.temporaryShape = shape.layer
      }

      fetch(url, {
        headers: { "Accept": "text/vnd.turbo-stream.html" }
      })
        .then(response => response.text())
        .then(html => Turbo.renderStreamMessage(html))

      this.map.pm.disableDraw()
    })
  }

  setupEventListeners() {
    window.addEventListener("modal:closed", () => {
      if (this.temporaryShape) {
        this.map.removeLayer(this.temporaryShape)
        this.temporaryShape = null
      }
    })

    document.addEventListener("turbo:before-stream-render", (event) => {
      const stream = event.target

      if (stream.action === "dispatch" && stream.target === "map") {
        const data = JSON.parse(stream.templateContent.textContent)
        console.log("Received sighting data:", data)
        this.addSightingToMap(data, true)
        event.preventDefault()
      }
    })
  }

  addSightingToMap(sighting, triggerClick = false) {
    if (sighting.type === "PointSighting") {
      const marker = L.marker([sighting.lat, sighting.lng]).addTo(this.map)
      marker.on('click', () => {
        this.map.setView(marker.getLatLng(), 14)
        Turbo.visit(sighting.url, { frame: 'sighting' })
      })
      if (triggerClick) marker.fire('click')
    }

    if (sighting.type === "PathSighting") {
      const polyline = L.polyline(sighting.path, { color: 'blue' }).addTo(this.map)
      polyline.on('click', () => {
        this.map.fitBounds(polyline.getBounds())
        Turbo.visit(sighting.url, { frame: 'sighting' })
      })
      if (triggerClick) polyline.fire('click')
    }

    if (sighting.type === "ZoneSighting") {
      const latlngs = sighting.zone.map(p => [p.lat, p.lng])
      const polygon = L.polygon(latlngs, { color: 'green' }).addTo(this.map)
      polygon.on('click', () => {
        this.map.fitBounds(polygon.getBounds())
        Turbo.visit(sighting.url, { frame: 'sighting' })
      })
      if (triggerClick) polygon.fire('click')
    }
  }
}
