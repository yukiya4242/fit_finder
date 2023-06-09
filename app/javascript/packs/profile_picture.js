// ターボリンクス
window.document.addEventListener('turbolinks:load', function() {

//document.addEventListener('DOMContentLoaded', () => {
  const profilePictureInput = document.getElementById('profile-picture-input');

  if (profilePictureInput) {
    profilePictureInput.addEventListener('change', (event) => {
      const input = event.target;
      const file = input.files[0];
      const reader = new FileReader();

      reader.onload = (e) => {
        const profilePicture = document.querySelector('.profile-picture');
        profilePicture.src = e.target.result;
      };

      reader.readAsDataURL(file);
    });
  }
//});
}, false)