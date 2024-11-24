import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="previews"
export default class extends Controller {
  static targets = ["input", "preview"]

  preview() {
    const input = this.inputTarget
    const previewContainer = this.previewTarget

    // Clear previous previews
    previewContainer.innerHTML = ""

    if (input.files.length > 4) {
      if (input.accept.includes("video")) {
        if (input.files.length > 1) {
          alert("You can only upload one video.")
          input.value = ""
          return
        }
      } else {
        alert("You can only upload up to 4 images.")
        input.value = ""
        return
      }
    }

    // Iterate through files and create previews
    for (const file of input.files) {
      const reader = new FileReader()
      const fileURL = URL.createObjectURL(file)
      const fileType = file.type

      let mediaElement

      if (fileType.startsWith('image/')) {
        // Create image preview
        mediaElement = document.createElement("img")
        mediaElement.src = fileURL
        mediaElement.className = "image-preview"
      } else if (fileType.startsWith('video/')) {
        // Create video preview
        mediaElement = document.createElement("video")
        mediaElement.src = fileURL
        mediaElement.className = "video-preview"

        mediaElement.controls = true // Add video controls
      }

      if (mediaElement) {
        previewContainer.appendChild(mediaElement)
      }
    }
  }
}
