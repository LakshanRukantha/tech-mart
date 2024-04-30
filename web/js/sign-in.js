document.addEventListener("DOMContentLoaded", function () {
  // Sign In Form Validations

  const signInForm = document.getElementById("signInForm");
  const signInAlertMessageArea = document.getElementById(
    "signInAlertMessageArea"
  );

  signInForm.addEventListener("submit", function (event) {
    event.preventDefault();

    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    // Check if any field is empty
    if (!email.trim()) {
      signInErrorMessage("email is required.");
      return;
    } else if (email.indexOf(" ") !== -1) {
      signInErrorMessage("Invalid email.");
      return;
    } else if (!password.trim()) {
      signInErrorMessage("Password is required.");
      return;
    }

    signInForm.submit();
  });

  function signInErrorMessage(message) {
    signInAlertMessageArea.classList.add(
      "alert",
      "alert-danger",
      "mt-4",
      "mb-0"
    );
    signInAlertMessageArea.innerText = message;
  }
});