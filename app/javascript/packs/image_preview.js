document.addEventListener('DOMContentLoaded', () => {
  const inputElement = document.getElementById('profile-picture-input');
  const previewImage = document.querySelector('.profile-picture');

  inputElement.addEventListener('change', (event) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      previewImage.src = e.target.result;
    };
    reader.readAsDataURL(event.target.files[0]);
  });
});
