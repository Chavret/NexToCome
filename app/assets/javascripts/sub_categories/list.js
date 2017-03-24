$(document).ready(function(){
  $(".category-bar-dd").on("click", ".category-dropdown", function() {
    var categoryId = $(this).data("category-id");
    if ($("#show-category-" + categoryId).css('display') == 'none'){
      $(".dropdown-border").addClass("hide");
      $(".arrow-category").addClass(".fa fa-angle-double-up").removeClass(".fa fa-angle-double-down");
      $("#show-category-" + categoryId).removeClass("hide");
      $("#arrow-category-" + categoryId).toggleClass(".fa fa-angle-double-up").toggleClass(".fa fa-angle-double-down");
    }else{
      $("#show-category-" + categoryId).toggleClass("hide");
      $("#arrow-category-" + categoryId).toggleClass(".fa fa-angle-double-up").toggleClass(".fa fa-angle-double-down");
    };
  });

});
