$(function() {
  // いいねボタンがクリックされたら
  $('body').on('click', '.fa-home', function(){
    console.log('active')
    // 現在の状態を取得
    var active = $(this).hasClass('active');
    // いいねの数の要素を取得
    var count = $(this).siblings('.like-count');
    // いいねの数を取得
    var currentCount = parseInt(count.text());
    // いいねの数を更新
    count.text(active ? currentCount - 1 : currentCount + 1);
    // ハートマークの状態を更新
    $(this).toggleClass('active');

    // いいねが成功したら
    $.ajax({
      url: $(this).data('url'),
      type: active ? 'DELETE' : 'POST',
      dataType: 'json',
    })
    .done(function(data) {
      // var like = data.data;
      // var url = active ? '/posts/' + like.post_id + '/likes' : '/posts/' + like.post_id + '/likes/' + like.id ;
      // console.log(url);
      // console.log($(this));

      // console.log($(this));
      console.log(data);
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });

    // ボタンのデフォルト動作を無効化
    // return false;
  });
});
