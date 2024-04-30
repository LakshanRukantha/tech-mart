document.addEventListener("DOMContentLoaded", function () {
  // SIgn Up Form Validations
  const registerform = document.getElementById("registerform");
  const registerAlertMessageArea = document.getElementById(
    "registerAlertMessageArea"
  );

  registerform.addEventListener("submit", function (event) {
    event.preventDefault();

    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const confirmpassword = document.getElementById("confirmpassword").value;

    // Check if any field is empty
    if (!name.trim()) {
      registerErrorMessage("Full name is required.");
      return;
    } else if (!email.trim()) {
      registerErrorMessage("Email is required.");
      return;
    } else if (email.indexOf(" ") !== -1) {
      registerErrorMessage("Email cannot contain spaces.");
      return;
    } else if (!password.trim()) {
      registerErrorMessage("Password is required.");
      return;
    } else if (!confirmpassword.trim()) {
      registerErrorMessage("Confirm Password is required.");
      return;
    } else if (password !== confirmpassword) {
      registerErrorMessage("Password and Confirm Password doesn't match.");
      return;
    }

    registerform.submit();
  });

  function registerErrorMessage(message) {
    registerAlertMessageArea.classList.add(
      "alert",
      "alert-danger",
      "mt-4",
      "mb-0"
    );
    registerAlertMessageArea.innerText = message;
  }
  }); 
    
  