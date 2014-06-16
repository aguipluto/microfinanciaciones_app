fb_root = null
fb_events_bound = false

$ ->
  loadFacebookSDK()
  bindFacebookEvents() unless fb_events_bound

bindFacebookEvents = ->
  $(document)
  .on('page:fetch', saveFacebookRoot)
  .on('page:change', restoreFacebookRoot)
  .on('page:load', ->
      FB?.XFBML.parse()
    )
  fb_events_bound = true

saveFacebookRoot = ->
  fb_root = $('#fb-root').detach()

restoreFacebookRoot = ->
  if $('#fb-root').length > 0
    $('#fb-root').replaceWith fb_root
  else
    $('body').append fb_root

loadFacebookSDK = ->
  window.fbAsyncInit = initializeFacebookSDK
  $.getScript("//connect.facebook.net/en_US/all.js#xfbml=1")

initializeFacebookSDK = ->
  FB.init
    appId     : '<%= ENV["FACEBOOK_KEY"] %>'
    status    : true
    cookie    : true
    xfbml     : true


#$ ->
#  $('body').prepend('<div id="fb-root"></div>')
#  FB.init(appId: '<%= ENV["FACEBOOK_KEY"] %>', cookie: true, xfbml: true, version: 'v2.0')
#
#  $.ajax
#    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
#    dataType: 'script'
#    cache: true


#window.fbAsyncInit = ->
#  $('#fb_sign_in').click (e) ->
#    e.preventDefault()
#    FB.login (response) ->
#      window.location = '/auth/facebook/callback' if response.authResponse

#  $('#sign_out').click (e) ->
#    FB.getLoginStatus (response) ->
#      FB.logout() if response.authResponse
#    true

