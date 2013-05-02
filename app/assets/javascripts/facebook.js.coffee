jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init(appId: "312502802217343", cookie: true)

  $('#facebook_login').click (e) ->
    e.preventDefault()
    FB.login ((response) ->
      window.location = '/users/auth/facebook/callback' if response.authResponse), scope: "email,user_birthday"
