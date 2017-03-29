$(document).ready(function(){
  $(".dropdown-border").hide();
  $(".arrow-category").addClass(".fa fa-angle-double-up").removeClass(".fa fa-angle-double-down");
  $(".category-bar-dd").on("click", ".category-dropdown", function() {
    var categoryId = $(this).data("category-id");
    if ($("#show-category-" + categoryId).css('display') == 'none'){
      $(".dropdown-border").hide();
      $(".arrow-category").addClass(".fa fa-angle-double-up").removeClass(".fa fa-angle-double-down");
      $("#show-category-" + categoryId).show();
      $("#arrow-category-" + categoryId).removeClass(".fa fa-angle-double-up").addClass(".fa fa-angle-double-down");
    }else{
      $("#show-category-" + categoryId).hide();
      $("#arrow-category-" + categoryId).toggleClass(".fa fa-angle-double-up").toggleClass(".fa fa-angle-double-down");
    };
  });


});

