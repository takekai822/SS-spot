// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery";
import raty from 'raty-js'
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

window.$ = window.jQuery = require('jquery');
global.$ = global.jQuery = require('jquery');

//ハンバーガーメニュー
/* global $*/
$(document).on('turbolinks:load', function() {
	$('.menu-button').click(function () {
		$(this).toggleClass('active');
		$('.open-menu-bg').fadeToggle();
		$('nav').toggleClass('open');
	})
	$('.open-menu-bg').click(function () {
		$(this).fadeOut();
		$('.menu-button').removeClass('active');
		$('nav').removeClass('open');
	});
})