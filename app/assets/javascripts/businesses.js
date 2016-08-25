$(document).ready(function () {
  toggleMenu("#online", "#all");
  toggleMenu("#categories", "#more");
  toggleMenu("#business", "#items");
});

function toggleMenu (buttonID, listID){
  $(buttonID).on("click", function(){
    $(listID).toggleClass("hidden");
  });
}
