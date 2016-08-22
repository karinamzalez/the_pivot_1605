$(document).ready(function () {
  toggleMenu("#online", "#all");
  toggleMenu("#categories", "#more");
});

function toggleMenu (buttonID, listID){
  $(buttonID).on("click", function(){
    $(listID).toggleClass("hidden");
  });
}
