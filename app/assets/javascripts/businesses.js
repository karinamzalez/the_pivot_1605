$(document).ready(function () {

  function toggleMenu (buttonID, listID){
    $(buttonID).on("click", function(){
      $(listID).toggleClass("hidden")
    });
  };

  toggleMenu("#online", "#all")
  toggleMenu("#categories", "#more")
});
