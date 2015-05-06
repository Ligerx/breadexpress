// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require foundation
//= require stickyFooter
//= require_tree .

$(function(){ $(document).foundation(); });






//// Shipper page js

$('.shipper-row label').click(function(event) {
  //Disable the native checkbox click
  event.stopPropagation();
});

$('.shipper-row').click(function(event) {
  //only get the first element (that was clicked on)
  event.stopPropagation();
  var checkbox = $(this).find('input');

  if (checkbox.is(':checked')) {
    checkbox.prop('checked', false);
  }
  else {
    checkbox.prop('checked', true);
  }
});