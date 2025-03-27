$(document).ready(function () {
  $("#btn_save").on("click", function () {
    var txt_name = $("#user_name").val();
    var txt_message = $("#user_message").val();

    // Basic validation
    if (!txt_name.trim() || !txt_message.trim()) {
      $("#response")
        .removeClass("sending success")
        .addClass("error")
        .text("Please fill in all fields")
        .css("display", "block");
      return;
    }

    // Disable button during submission
    $(this).prop("disabled", true);

    $.ajax({
      url: "http://35.224.5.250:30005/",
      type: "post",
      data: { user_name: txt_name, user_message: txt_message },
      beforeSend: function () {
        $("#response")
          .removeClass("success error")
          .addClass("sending")
          .text("Sending your message...")
          .css("display", "block");
      },
    })
      .done(function (e) {
        $("#response")
          .removeClass("sending error")
          .addClass("success")
          .text("Message sent successfully!")
          .css("display", "block");

        // Clear form fields on success
        $("#user_name").val("");
        $("#user_message").val("");
      })
      .fail(function () {
        $("#response")
          .removeClass("sending success")
          .addClass("error")
          .text("Something went wrong. Please try again.")
          .css("display", "block");
      })
      .always(function () {
        // Re-enable button after completion
        $("#btn_save").prop("disabled", false);
      });
  });

  // Add enter key support for form
  $("#user_message").keydown(function (e) {
    if (e.keyCode == 13 && e.ctrlKey) {
      $("#btn_save").click();
      e.preventDefault();
    }
  });
});
