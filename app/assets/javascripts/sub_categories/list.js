$(document).ready(function(){
  // $(".dropdown-border").hide();
  $(".arrow-category").addClass(".fa fa-angle-double-down").removeClass(".fa fa-angle-double-up");
  $(".category-bar-dd").on("click", ".category-dropdown", function() {
    var categoryId = $(this).data("category-id");
    if ($("#show-category-" + categoryId).css('display') == 'none'){
      $(".dropdown-border").hide();
      $(".arrow-category").addClass(".fa fa-angle-double-down").removeClass(".fa fa-angle-double-up");
      $("#show-category-" + categoryId).show();
      $("#arrow-category-" + categoryId).removeClass(".fa fa-angle-double-down").addClass(".fa fa-angle-double-up");
    }else{
      $("#show-category-" + categoryId).hide();
      $("#arrow-category-" + categoryId).toggleClass(".fa fa-angle-double-down").toggleClass(".fa fa-angle-double-up");
    };
  });


});

