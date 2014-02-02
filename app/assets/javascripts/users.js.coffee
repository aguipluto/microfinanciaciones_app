# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ValidarEnviarFormulario = () ->
  $('form').submit (event) ->
    unless (ValidarLongitudMinima('#user_name', 3) & ValidarLongitudMinima('#user_family_name', 3) & ValidarLongitudMinima('#user_email', 5) & ValidarLongitudMinima('#user_password', 6) & ValidarLongitudMinima('#user_password_confirmation', 6) & ValidarPoliticaPrivacidad())
      $('html, body').animate({scrollTop:0}, 'slow');
      $('#error_explanation_js').show()
      event.preventDefault()


ValidarLongitudMinima = (elemento, longitud) ->
  element = $(elemento)
  if element.val().length < longitud
    element.parent().addClass("has-error")
    false
  else
    element.parent().removeClass("has-error")
    true

ValidarPoliticaPrivacidad = () ->
  unless $('#user_terms_of_service').is(':checked')
    $('#user_terms_of_service').parent().css('font-weight', 'bold')
    $('#user_terms_of_service').parent().css('color', '#b94a48')
    false
  else
    $('#user_terms_of_service').parent().css('font-weight', 'normal')
    $('#user_terms_of_service').parent().css('color', '#333333')
    true



ValidarFormulario = () ->
  $('#user_name').blur ->
    ValidarLongitudMinima('#user_name', 3)
  $('#user_family_name').blur ->
    ValidarLongitudMinima('#user_family_name', 3)
  $('#user_email').blur ->
    ValidarLongitudMinima('#user_email', 5)
  $('#user_password').blur ->
    ValidarLongitudMinima('#user_password', 6)
  $('#user_password_confirmation').blur ->
    ValidarLongitudMinima('#user_password_confirmation', 6)


$ ->
  ValidarFormulario()
  ValidarEnviarFormulario()

  $('#aceptoPrivacidad').click ->
    $('#user_terms_of_service').prop('checked', true);