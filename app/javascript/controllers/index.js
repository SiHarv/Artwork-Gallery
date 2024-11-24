// app/javascript/controllers/index.js
import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";

// Initialize Stimulus application
const application = Application.start();

// Load controllers from the controllers directory
const context = require.context(".", true, /\.js$/);
application.load(definitionsFromContext(context));
