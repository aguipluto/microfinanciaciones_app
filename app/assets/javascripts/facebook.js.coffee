jQuery ->
  $('body').prepend('<div id="fb-root"></div>')
  FB.init(appId: '<%= ENV["FACEBOOK_KEY"] %>', cookie: true, xfbml: true, version: 'v2.0')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  $('#fb_sign_in').click (e) ->
    e.preventDefault()
    FB.login (response) ->
      window.location = '/auth/facebook/callback' if response.authResponse

#  $('#sign_out').click (e) ->
#    FB.getLoginStatus (response) ->
#      FB.logout() if response.authResponse
#    true

