$(document).ready(function () {
  $("#orderPlaceForm").submit(function (event) {
    event.preventDefault();

    var formData = new FormData(this);
    $.ajax({
      url: "PlaceOrderServlet",
      type: "POST",
      data: formData,
      processData: false,
      contentType: false,
      success: function (response) {
        $("#orderPlaceForm")[0].reset();
        $("#messageBox").html(
          "<div class='alert alert-success' role='alert'>" +
            response + " <a class='fw-semibold' href='./index.jsp'>Go Back</a>" +
            "</div>"
        );
      },
      error: function (xhr, status, error) {
        $("#messageBox").html(
          '<div class="alert alert-danger alert-dismissible fade show" role="alert">' +
            xhr.responseText +
            '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
        );
      },
    });
  });
});
