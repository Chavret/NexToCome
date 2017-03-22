$(document).ready(function() {
  $(".new_form").hide();
  $(".edit_form").hide();
  $(".btn_create").on("click", function(e){
    if ($(".new_form").css('display') == 'none'){
      $(".new_form").slideDown();
    }else {
      $(".new_form").slideUp();
    }
  });

  $(".events_admin").on("click", function(e) {
    var index = $(".events_admin").parent().index(this);
    if ($(this).parent().find(".edit_form").css('display') == 'none'){
      $(this).parent().find(".edit_form").slideDown();
      $(this).parent().find(".events_admin").addClass("event-select");
      $(this).parent().find(".events_admin").removeClass("events_admin");
    }else {
      $(this).parent().find(".edit_form").slideUp();
      $(this).parent().find(".event-select").addClass("events_admin");
      $(this).parent().find(".events_admin").removeClass("event-select");

    }
  });
  var more = false

  $("#submit_button").submit(function(event) {

  /* stop form from submitting normally */
   event.preventDefault();

  /* get values from elements on the page: */
   var more = $('#radio-button').val();

  /* Send the data using post and put the results in a div */
    $.ajax({
      url: "/admin/?more="+more,
      type: "get",
      data: values,
      success: function(){
        alert('Loaded Successfully');
      },
      error:function(){
       alert('Error');
      }
    });
  });

})
