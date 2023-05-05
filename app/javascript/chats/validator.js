$(document).ready(function() {
  $('.errors').html("<%= j(render 'layouts/errors', obj: @chat) %>");
});
