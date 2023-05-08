$(document).on('ajax:success', '.follow-button', function(event) {
  const userId = $(this).attr('id').split('-')[2];
  $(`#follow-button-${userId}`).hide();
  $(`#unfollow-button-${userId}`).show();
});

$(document).on('ajax:success', '.unfollow-button', function(event) {
  const userId = $(this).attr('id').split('-')[2];
  $(`#unfollow-button-${userId}`).hide();
  $(`#follow-button-${userId}`).show();
});
