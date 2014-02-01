# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

AbrirModalProyecto = () ->
  $('.proyectoHome').click (event) ->
    $.ajax '/prueba',
      type: 'GET'
      data: {id: $(this).attr("id")}
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        alert  errorThrown
      success: (data, textStatus, jqXHR) ->
          console.log(data)
          $('#modalProyecto').modal('show')
          $('#modalTitle').text(data.titulo)
          $('#modalImg').attr('src', data.attachments[1].url)
          $('#modalDescripcionLarga').text(data.descripcion_larga)
          $('#modalFecha').html('Desde ' + data.fechaInicio + ' hasta ' + data.fechaFin)
          $('#modalLugar').html('Lugar:' + data.lugar)
          $('#modalProgress').attr('aria-valuenow', data.total_collected)
          $('#modalProgress').attr('aria-valuemax', data.cantidad_total)
          $('#modalProgress').css('width', (data.total_collected * 100) / data.cantidad_total + '%')
          $('#modalQueda').html('Quedan:' + data.queda)
          $('#modalRecaudado').html('Conseguidos ' + data.total_collected + "&euro;")
          $('#aportationInfo').html($('#aportationSlider').val() + '&euro;' )


$ ->
  AbrirModalProyecto()
  $('#aportationSlider').change () ->
    cantidad = $(this).val()
    console.log(cantidad)
    $('#aportationInfo').html(cantidad + '&euro;')

