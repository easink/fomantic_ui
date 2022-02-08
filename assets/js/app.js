// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
import "../css/app.css"

import "phoenix_html"

import "./jquery-globals"

import "fomantic-ui-css/semantic"

console.log('app.js pre alpinejs')
import Alpine from 'alpinejs'
window.Alpine = Alpine
Alpine.start()
console.log('app.js post alpinejs')

import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"

console.log('app.js before /live')
// $('.ui.dropdown').dropdown();

let Hooks = {}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
    params: {_csrf_token: csrfToken},
    hooks: Hooks,
    dom: {
      onBeforeElUpdated(from, to) {
        // if (!window.Alpine) return;
        // if (from.nodeType !== 1) return;

        if (from._x_dataStack) {
          Alpine.clone(from, to)
          // Alpine.initTree(to)
        }
      }
    }
})

liveSocket.connect()

console.log('last app.js')
// for debug
// window.liveSocket = liveSocket

// in the browser's web console
// >> liveSocket.enableDebug()

