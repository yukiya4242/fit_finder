document.addEventListener('DOMContentLoaded', () => {
  const postPictureInput = document.getElementById('post-picture-input');

  // 要素が存在する場合のみイベントリスナーを追加
  if (postPictureInput) {
    postPictureInput.addEventListener('change', (event) => {
      const input = event.target;
      const file = input.files[0];
      if (file) {
        const reader = new FileReader();

        reader.onload = (e) => {
          const postPicture = document.querySelector('.post-picture');
          if (postPicture) {
            postPicture.src = e.target.result;
          }
        };

        reader.readAsDataURL(file);
      }
    });
  }
});
