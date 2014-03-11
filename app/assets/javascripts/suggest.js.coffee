# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

AbrirModalSuggest = () ->
  $(document).on 'click', '#suggests tbody tr', (event) ->
    id = $(this).attr("id")
    $(this).addClass('suggest-shown')
    $('#modalId').text(id)
    console.log($(this))
    $.ajax '/suggests/' + $(this).attr("id"),
      type: 'GET'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        console.log errorThrown
      success: (data, textStatus, jqXHR) ->
        console.log(data)
        $('.loading').addClass('hidden');
        $('#modalSuggest').modal('show')
        $('#modalTitle').html('Recibido el ' + data.suggest.createdAt)
        $('#modalNombre').html('Nombre: <strong>' + data.suggest.name + '</strong>')
        $('#modalEmail').html('Email: <strong>' + data.suggest.email + '</strong>')
        $('#modalTel').html('Teléfono: <strong>' + data.suggest.tel + '</strong>')
        $('#modalTit').html('Asunto: <strong>' + data.suggest.title + '</strong>')
        $('#modalSug').html('<strong>' + data.suggest.suggestion.replace(/\r\n/, '<br/>') + '</strong>')
        $('#unread_suggests').text('Buzon' + data.unread_suggests)
        if data.suggest.answer
          $('#suggestion-answer').addClass('hidden')
          $('#contenido-answer').text(data.suggest.answer.replace(/\r\n/, '<br/>'));
        else
          $('#suggestion-answer').removeClass('hidden')
          $('#contenido-answer').text('');


AnswerSuggest = () ->
  $('#btnAnswerSuggest').click (event) ->
    $('.loading').removeClass('hidden');
    respuesta = $('#suggestion-answer').val()
    if respuesta
      idSuggest = $('#modalId').text()
      $.ajax '/suggests/' + idSuggest,
        type: 'PUT'
        data: {suggest: {id: idSuggest, answer: respuesta}}
        dataType: 'json'
        error: (jqXHR, textStatus, errorThrown) ->
          alert(errorThrown + ' ' + textStatus + ' ' + jqXHR)
        success: (data, textStatus, jqXHR) ->
          console.log(data)
          if data.result == '0'
            $('#suggestion-answer').addClass('hidden')
            $('#contenido-answer').text(respuesta.replace(/\r\n/, '<br/>'));
            $('#tick-suggest-answered-'+idSuggest).html('<span class="glyphicon glyphicon-ok"></span>')
            $('.loading').addClass('hidden');
          else
            $('#contenido-answer').text('Ha ocurrido un error. Por favor, intente de nuevo más tarde.')
            $('.loading').addClass('hidden');
    else
      $('#contenido-answer').text('Por favor, escriba una respuesta.')
      $('.loading').addClass('hidden');

$ ->
  AbrirModalSuggest()
  AnswerSuggest()
