# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ValidarEnviarFormulario = () ->
  $('#formulario-registro').submit (event) ->
    unless (ValidarLongitudMinima('#user_name', 3) & ValidarLongitudMinima('#user_family_name',
      3) & ValidarLongitudMinima('#user_email', 5) & ValidarLongitudMinima('#user_password',
      6) & ValidarLongitudMinima('#user_password_confirmation', 6) & ValidarPoliticaPrivacidad())
      $('html, body').animate({scrollTop: 0}, 'slow');
      $('#error_explanation_js').show()
      event.preventDefault()
  $('#formulario-editar').submit (event) ->
    unless (ValidarLongitudMinima('#user_name', 3) & ValidarLongitudMinima('#user_family_name',
      3) & ValidarLongitudMinima('#user_email', 5) )
      $('html, body').animate({scrollTop: 0}, 'slow');
      $('#error_explanation_js').show()
      event.preventDefault()
  $('#suggest_form').submit (event) ->
    unless (ValidarLongitudMinima('#suggest_name', 3) & ValidarLongitudMinima('#suggest_email',
      3) & ValidarLongitudMinima('#suggest_suggestion', 5) )
      $('html, body').animate({scrollTop: 0}, 'slow');
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
#  Usuarios
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
#Sugerencias
  $('#suggest_name').blur ->
    ValidarLongitudMinima('#suggest_name', 3)
  $('#suggest_suggestion').blur ->
    ValidarLongitudMinima('#suggest_suggestion', 5)


MenuIzqClicked = () ->
  $('#menuIzqPerfil').click ->
    $('h2').text('Perfil de Usuario')
    $('#menuIzqPerfil').addClass('active')
    $('#menuIzqEditar').removeClass('active')
    $('#menuIzqCambiar').removeClass('active')
    $('#menuIzqPagos').removeClass('active')
    $('#menuIzqVoluntarios').removeClass('active')
    $('#perfilDeUsuario').removeClass('hidden')
    $('#editarPerfilDeUsuario').addClass('hidden')
    $('#changePassword').addClass('hidden')
    $('#aportacionesRealizadas').addClass('hidden')
    $('#proyectosVoluntario').addClass('hidden')
  $('#menuIzqEditar').click ->
    $('h2').text('Editar Usuario')
    $('#menuIzqPerfil').removeClass('active')
    $('#menuIzqEditar').addClass('active')
    $('#menuIzqCambiar').removeClass('active')
    $('#menuIzqPagos').removeClass('active')
    $('#menuIzqVoluntarios').removeClass('active')
    $('#perfilDeUsuario').addClass('hidden')
    $('#editarPerfilDeUsuario').removeClass('hidden')
    $('#changePassword').addClass('hidden')
    $('#aportacionesRealizadas').addClass('hidden')
    $('#proyectosVoluntario').addClass('hidden')
  $('#menuIzqCambiar').click ->
    $('h2').text('Cambiar contraseña')
    $('#menuIzqPerfil').removeClass('active')
    $('#menuIzqEditar').removeClass('active')
    $('#menuIzqCambiar').addClass('active')
    $('#menuIzqPagos').removeClass('active')
    $('#menuIzqVoluntarios').removeClass('active')
    $('#perfilDeUsuario').addClass('hidden')
    $('#editarPerfilDeUsuario').addClass('hidden')
    $('#changePassword').removeClass('hidden')
    $('#aportacionesRealizadas').addClass('hidden')
    $('#proyectosVoluntario').addClass('hidden')
  $('#menuIzqPagos').click ->
    $('h2').text('Aportaciones Realizadas')
    $('#menuIzqPerfil').removeClass('active')
    $('#menuIzqEditar').removeClass('active')
    $('#menuIzqCambiar').removeClass('active')
    $('#menuIzqVoluntarios').removeClass('active')
    $('#menuIzqPagos').addClass('active')
    $('#perfilDeUsuario').addClass('hidden')
    $('#editarPerfilDeUsuario').addClass('hidden')
    $('#changePassword').addClass('hidden')
    $('#aportacionesRealizadas').removeClass('hidden')
    $('#proyectosVoluntario').addClass('hidden')
  $('#menuIzqVoluntario').click ->
    $('h2').text('Voluntario en')
    $('#menuIzqPerfil').removeClass('active')
    $('#menuIzqEditar').removeClass('active')
    $('#menuIzqCambiar').removeClass('active')
    $('#menuIzqPagos').removeClass('active')
    $('#menuIzqVoluntarios').addClass('active')
    $('#perfilDeUsuario').addClass('hidden')
    $('#editarPerfilDeUsuario').addClass('hidden')
    $('#changePassword').addClass('hidden')
    $('#aportacionesRealizadas').addClass('hidden')
    $('#proyectosVoluntario').removeClass('hidden')


$ ->
  ValidarFormulario()
  ValidarEnviarFormulario()
  MenuIzqClicked()

#  TR de las tablas como links
  $(document).on 'click', 'tr[data-link]', (event) ->
    window.location = $(this).data("link")


  $('#aceptoPrivacidad').click ->
    $('#user_terms_of_service').prop('checked', true);

  $('#change_password').click (event) ->
    event.preventDefault()
    $(this).addClass('hidden')
    $('#div_change_password').removeClass('hidden')



