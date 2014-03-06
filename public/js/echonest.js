$(document).ready(function(){
  var artist = $(".artist-name").attr("id");
  var url = 'http://developer.echonest.com/api/v4/artist/news';
 
  var args = { 
            format:'json', 
            api_key: '1HBIPJWJYKGSJSTEF',
            name: artist,
            results: 5,
            high_relevance: true, 
    }; 

  $.get(url, args, function(data) {
                    console.log("makin' request");
                    if (data.response.news.length == 0) {$(".artist-news").append("<h2>Sorry no news today!</h2>");}
                    $.each(data.response.news, function(index, news) {
                      var div = formatNews(news);
                      $(".artist-news").append(div);
                    });
                  }
  );

  function formatNews(news) {
    var div = $("<div class='news well'>");
    div.append($("<h4>").html(news.name));

    var date = "";
    if ('date_posted' in news) {
        date = "<i>" + news.date_posted.substring(0,10) + '</i> ';
    }

    div.append($("<p>").html(date + news.summary + " ..." ));
    var link = $("<a>");
    link.attr('href', news.url);
    link.text("Read more here: " + getSource(news.url));
    div.append(link);
    return div;
  }

  function getSource(url) {
    var path = url.split('/');
    return path[2]  ;
  }

});
