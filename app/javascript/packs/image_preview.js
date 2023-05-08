document.addEventListener('DOMContentLoaded', () => {
  const inputElement = document.getElementById('profile-picture-input');
  const previewImage = document.querySelector('.profile-picture');

  console.log("inputElement:", inputElement);
  console.log("previewImage:", previewImage);

  if (inputElement && previewImage) {
    inputElement.addEventListener('change', (event) => {
      const reader = new FileReader();
      reader.onload = (e) => {
        previewImage.src = e.target.result;
      };
      reader.readAsDataURL(event.target.files[0]);
    });
  } else {
    console.error("要素が見つからないため、イベントリスナーを追加できません。");
  }
});
