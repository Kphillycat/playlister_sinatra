$(document).ready(function(){
  // $(".artist-news").append("<p>News go here</p>");
  var artist = $(".artist-name").attr("id");
  var url = 'http://developer.echonest.com/api/v4/artist/news';
 
  var args = { 
            format:'json', 
            api_key: '1HBIPJWJYKGSJSTEF',
            name: artist,
            results: 5,
            // xhrFields: { withCredentials: true},
            high_relevance: true, 
    }; 

 $.get(url, args, 
                    function(data) {
                      console.log("makin' request");
                      console.log(data);
                      $.each(data.response.news, function(index, news) {
                        var div = formatNews(news);
                        $(".artist-news").append(div);
                      });
                      // $(".artist-news").
                    //     $(".artist-news").empty();
                    //     if (! ('news' in data.response)) {
                    //         console.log("error")
                    //         error("Can't find any news for " + artist);
                    //     } else {
                    //         console.log(data);
                    //         $(".artist-news").show();
                    //         var titles = {}
                    //         $.each(data.response.news, function(index, news) {
                    //             if (! (news.name in titles)) {
                    //                 var div = formatNews(news);
                    //                 $(".artist-news").append(div);
                    //                 titles[news.name] = 1;
                    //             }
                    //         });
                    //   info("Showing " + data.response.news.length + " of " + data.response.total + " news items for " + artist);
                    // }
                    // },
                    // function() {
                    //     error("Trouble getting news for " + artist);
                    }
  );

  function formatNews(news) {
    console.log("formatting");
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
 // $.getJSON(url, args, {crossDomain: true},
 //            function(data) {
 //              console.log("makin' request");
 //                $(".artist-news").empty();
 //                if (! ('news' in data.response)) {
 //                    console.log("error")
 //                    error("Can't find any news for " + artist);
 //                } else {
 //                    console.log(data);
 //                    $(".artist-news").show();
 //                    var titles = {}
 //                    $.each(data.response.news, function(index, news) {
 //                        if (! (news.name in titles)) {
 //                            var div = formatNews(news);
 //                            $(".artist-news").append(div);
 //                            titles[news.name] = 1;
 //                        }
 //                    });
 //                    info("Showing " + data.response.news.length + " of " + data.response.total + " news items for " + artist);
 //                }
 //            },
 //            function() {
 //                error("Trouble getting news for " + artist);
 //            }
 //        );

 //  function formatNews(news) {
 //    console.log("formatting");
 //    var div = $("<div class='news well'>");
 //    div.append($("<h4>").html(news.name));

 //    var date = "";
 //    if ('date_posted' in news) {
 //        date = "<i>" + news.date_posted.substring(0,10) + '</i> ';
 //    }

 //    div.append($("<p>").html(date + news.summary + " ..." ));
 //    var link = $("<a>");
 //    link.attr('href', news.url);
 //    link.text("full story on " + getSource(news.url));
 //    div.append(link);
 //    return div;
 //  }


});
