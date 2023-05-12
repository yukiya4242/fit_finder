$(document).ready(function() {
  $('.chat-message').each(function() {
    var messageId = $(this).data('message-id');

    $.post(`/chats/${messageId}/read`);
  });
});
