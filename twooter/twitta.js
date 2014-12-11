 var url = 'https://sweltering-inferno-6192.firebaseio.com';
    var firebaseRef = new Firebase(url);

    function funct1(event) {
        event.preventDefault();
        var tweet_content = $("#user-input").val();
        tweet_content = tweet_content.trim();
        if (tweet_content.length > 1){
            firebaseRef.push({tweet_text: tweet_content});
        }
    }

    function clearInput() {
      $('#user-input').val('');
    }


  //----- Event handlers -----//

    $('.submit').click(funct1);
    $('.submit').click(clearInput);
