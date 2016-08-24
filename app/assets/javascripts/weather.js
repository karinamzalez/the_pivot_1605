// Docs at http://simpleweatherjs.com
$(document).ready(function() {
  $.simpleWeather({
    woeid: '2357536', //2357536
    location: '',
    unit: 'f',
    success: function(weather) {
      if(weather.temp > 75) {
        $('body').animate({backgroundColor: '#F7AC57'}, 1500);
      } else {
        $('body').animate({backgroundColor: '#fff'}, 1500);
      }

      $("#display-location").html(weather.city+', '+weather.region);
      $("#current-weather-column").html(weather.currently);

      var timestamp = moment(weather.updated);
      html += '<p class="updated">Updated '+moment(timestamp).fromNow()+'</p>';

      $("#weather").html(html);
    },
    error: function(error) {
      $("#weather").html('<p>'+error+'</p>');
    }
  });
});
