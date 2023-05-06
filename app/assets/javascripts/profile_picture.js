document.addEventListener("DOMContentLoaded", function() {
  const profilePictureContainer = document.querySelector(".profile-picture-container");
  const profilePictureInput = document.getElementById("profile-picture-input");

  profilePictureContainer.addEventListener("click", function() {
    profilePictureInput.click();
  });
});
