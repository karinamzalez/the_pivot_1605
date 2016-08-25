$(document).ready(function(){

  var $gnomes = $('.gnome');

  $gnomes.each(function(index, gnome){

    $(gnome).on('mouseenter', function(){
      if ($(gnome).find('#more-button').is(':hidden')){
        $(gnome).find('#more-button').slideToggle(500);
      }
    });

    $(gnome).on('mouseleave', function(){
      $(gnome).find('#more-button').slideToggle(500);
    });

    $(gnome).find('#more-button').on('click', function(){
      if ($(gnome).hasClass('retired')){
        $(gnome).find('a').removeAttr('href');
        $(gnome).find('img').replaceWith("<img class='thumbnail' src='http://blog.arkieva.com/wp-content/uploads/2015/09/stockout.jpg'>");
      }
    });
  });

  $('#bucket-link').on('mouseenter', function(){
    if ($('#bucket-link').find('.label').is(':hidden')){
      $('#bucket-link').find('.label').fadeIn(200);
    }
  });

  $('#bucket-link').on('mouseleave', function(){
    $('#bucket-link').find('.label').fadeOut(200);
  });
});
