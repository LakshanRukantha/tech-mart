$(document).ready(function () {
  $("#createProductForm").submit(function (event) {
    event.preventDefault();

    var formData = new FormData(this);
    $.ajax({
      url: "CreateProductServlet",
      type: "POST",
      data: formData,
      cache: false,
      contentType: false,
      processData: false,
      success: function (response) {
        $("#messageBox").html(
          '<div class="alert alert-success alert-dismissible fade show" role="alert">' +
            response +
            '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
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