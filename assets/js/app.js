import "phoenix_html"
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import {hooks as colocatedHooks} from "phoenix-colocated/medigrand"
import topbar from "../vendor/topbar"

const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
const HeroSlider = {
  mounted() {
    this.slides = Array.from(this.el.querySelectorAll("[data-slide]"))
    this.dots = Array.from(this.el.querySelectorAll("[data-dot]"))
    this.index = 0

    if (this.slides.length === 0) return

    this.show = index => {
      this.slides.forEach((slide, idx) => {
        slide.classList.toggle("is-active", idx === index)
      })
      this.dots.forEach((dot, idx) => {
        dot.classList.toggle("is-active", idx === index)
      })
    }

    this.step = direction => {
      const length = this.slides.length
      this.index = direction === "next"
        ? (this.index + 1) % length
        : (this.index - 1 + length) % length
      this.show(this.index)
    }

    this.boundClick = event => {
      const button = event.target.closest("[data-dir]")
      if (!button) return
      this.step(button.dataset.dir)
      this.restart()
    }

    this.restart = () => {
      if (this.timer) clearInterval(this.timer)
      this.timer = setInterval(() => this.step("next"), 5000)
    }

    this.el.addEventListener("click", this.boundClick)
    this.show(this.index)
    this.restart()
  },

  destroyed() {
    if (this.timer) clearInterval(this.timer)
    if (this.boundClick) this.el.removeEventListener("click", this.boundClick)
  },
}

const hooks = {
  ...colocatedHooks,
  HeroSlider,
}

const liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks,
})

topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

liveSocket.connect()

window.liveSocket = liveSocket

if (process.env.NODE_ENV === "development") {
  window.addEventListener("phx:live_reload:attached", ({detail: reloader}) => {
    reloader.enableServerLogs()

    let keyDown
    window.addEventListener("keydown", e => keyDown = e.key)
    window.addEventListener("keyup", _e => keyDown = null)
    window.addEventListener("click", e => {
      if(keyDown === "c"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtCaller(e.target)
      } else if(keyDown === "d"){
        e.preventDefault()
        e.stopImmediatePropagation()
        reloader.openEditorAtDef(e.target)
      }
    }, true)

    window.liveReloader = reloader
  })
}
