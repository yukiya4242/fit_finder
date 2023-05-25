// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import $ from 'jquery';
window.$ = $;
window.jQuery = $;


import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

require("packs/post_picture")



// require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()
// require("channels")
// require("jquery")

import './likes'


Rails.start()
Turbolinks.start()
ActiveStorage.start()
