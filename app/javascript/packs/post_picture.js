document.addEventListener('DOMContentLoaded', () => {
  const postPictureInput = document.getElementById('post-picture-input');

  if (postPictureInput) {
    postPictureInput.addEventListener('change', (event) => {
      const input = event.target;
      const file = input.files[0];
      const reader = new FileReader();

      reader.onload = (e) => {
        const postPicture = document.querySelector('.post-picture');
        postPicture.src = e.target.result;
      };

      reader.readAsDataURL(file);
    });
  }
});
