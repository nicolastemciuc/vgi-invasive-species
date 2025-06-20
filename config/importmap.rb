# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "leaflet" # @1.9.4
pin "@geoman-io/leaflet-geoman-free", to: "@geoman-io--leaflet-geoman-free.js" # @2.18.3
pin "leaflet.locatecontrol" # @0.84.2
