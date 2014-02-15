$ ->
  $.setAjaxPagination = ->
    $('.pagination a').click (event) ->
      event.preventDefault()
      $.ajax type: 'GET', url: $(@).attr('href'), dataType: 'script', success: (-> loading.fadeOut -> loading.remove())
      false
  $.setAjaxPagination()