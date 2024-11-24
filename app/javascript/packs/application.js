// app/javascript/packs/application.js
import '@fortawesome/fontawesome-free/css/all.css'; // Import Font Awesome CSS
import { Application } from "@hotwired/stimulus";
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers";
import Rails from "@rails/ujs";

const application = Application.start();
const context = require.context("../controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

Rails.start();
