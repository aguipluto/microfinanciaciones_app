# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

SliderAportacionChange = () ->
  $('.aportationSlider').change () ->
    cantidad = $(this).val()
    console.log(cantidad)
    $('.aportationInfo').html(cantidad + '&euro;')

SessionCartNumberUpdate = () ->
  $.ajax '/getNumberOfItems',
    type: 'GET'
    dataType: 'json'
    success: (data, textStatus, jqXHR) ->
      if data['result'] > 0
        $('.badge').removeClass('hidden')
        $('.badge').html(data['result'])
      else
        $('.badge').addClass('hidden')


AbrirModalProyecto2 = () ->
  $(document).on 'click', '.carousel',  (event) ->
    event.stopPropagation()
  $(document).on 'click', '.proyectoHome',  (event) ->
    id = $(this).attr("id")
    $('#modalProyecto-' + id).modal('show')


AbrirModalProyecto = () ->
  $(document).on 'click', '.carousel',  (event) ->
    event.stopPropagation()

  $(document).on 'click', '.proyectoHome',  (event) ->
    id = $(this).attr("id")
    $('#modalId').text(id)
    $.ajax '/proyectos/' + $(this).attr("id"),
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log errorThrown
      success: (data, textStatus, jqXHR) ->
        $('#modalProyecto').modal('show')
        $('#modalTitle').text(data.titulo)
        $('#modalTitle').text(data.titulo)
        $('#modalImg').attr('src', data.attachments[0].url)
        $('#modalDescripcionLarga').html(data.descripcion_larga)
        $('#modalFecha').html('Desde ' + data.fechaInicio + ' hasta ' + data.fechaFin)
        $('#modalLugar').html('Lugar: ' + data.lugar)
        $('#modalProgress').attr('aria-valuenow', data.total_collected)
        $('#modalProgress').attr('aria-valuemax', data.cantidad_total)
        $('#modalProgress').css('width', (data.total_collected * 100) / data.cantidad_total + '%')
        $('#modalQueda').html('Quedan: ' + data.queda)
        $('#modalRecaudado').html('Conseguidos ' + data.total_collected + "&euro;")
        $('#aportationInfo').html($('#aportationSlider').val() + '&euro;')

RealizarAportacion = () ->
  $('#btnAportar').click (event) ->
    $.ajax '/cartItemCreate',
      type: 'POST'
      data: {aportacion: $('#aportationSlider').val(), proyecto_id: $('#modalId').text()}
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        alert 'Por favor, inicie sesión'
      success: (data, textStatus, jqXHR) ->
        SessionCartNumberUpdate()

this.myApi = {
  SessionCartNumberUpdate : SessionCartNumberUpdate
}

$ ->
#  AbrirModalProyecto()
  SliderAportacionChange()
  RealizarAportacion()
  $(document).ready ->
    SessionCartNumberUpdate()
  AbrirModalProyecto2()
  $('#scrollDown').click ->
    $('body').scrollspy({ target: '#main-content' })





