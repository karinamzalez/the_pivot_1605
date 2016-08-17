$(document).ready(function () {

  function toggleBusiness (marketID, boothID){
    $(marketID).on("click", function(){
      $(boothID).toggleClass("hidden")
    });
  };

  toggleBusiness("#online", "#all")
});
