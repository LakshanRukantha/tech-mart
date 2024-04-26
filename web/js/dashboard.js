$(document).ready(function () {
  $("#createProductForm").submit(function (event) {
    event.preventDefault(); // Prevent the form from submitting normally

    var formData = new FormData(this);
    $.ajax({
      url: "CreateProductServlet",
      type: "POST",
      data: formData,
      cache: false,
      contentType: false,
      processData: false,
      success: function (response) {
        $("#createProductMessage").html('<div class="alert alert-success" role="alert">' + response + '</div>');
      },
      error: function (xhr, status, error) {
        $("#createProductMessage").html('<div class="alert alert-danger" role="alert">Error: ' + xhr.responseText + '</div>');
      },
    });
  });
});
