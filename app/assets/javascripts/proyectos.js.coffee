MenuIzqClicked = () ->
  $('#menuIzqDatosProyecto').click ->
    $('#menuIzqDatosProyecto').addClass('active')
    $('#menuIzqImagenes').removeClass('active')
    $('#editarProyecto').removeClass('hidden')
    $('#editarImagenesProyecto').addClass('hidden')
  $('#menuIzqImagenes').click ->
    $('#menuIzqDatosProyecto').removeClass('active')
    $('#menuIzqImagenes').addClass('active')
    $('#editarProyecto').addClass('hidden')
    $('#editarImagenesProyecto').removeClass('hidden')

MenuIzqShowProjectClicked = () ->
  $('#menuIzqShowProject').click ->
    $('#menuIzqShowProject').addClass('active')
    $('#menuIzqBlogProject').removeClass('active')
    $('#showProject').removeClass('hidden')
    $('#blogProject').addClass('hidden')
  $('#menuIzqBlogProject').click ->
    $('#menuIzqShowProject').removeClass('active')
    $('#menuIzqBlogProject').addClass('active')
    $('#showProject').addClass('hidden')
    $('#blogProject').removeClass('hidden')

$(document).on 'click', '.btn-delete-img-p', (event) ->
  id = $(this).attr("id")
  $.ajax '/deleteAttachment',
    data: {id: id}
    type: 'DELETE'
    dataType: 'json'
    error: (jqXHR, textStatus, errorThrown) ->
      console.log errorThrown
    success: (data, textStatus, jqXHR) ->
      $('div#attachment-' + id).fadeOut(300, ->
        $(this).remove())

#$(document).ready ->
#  $("#edit_proyecto_3").on("ajax:success", (e, data, status, xhr) ->
#    alert 'funcioooona'
#  ).bind "ajax:error", (e, xhr, status, error) ->
#    alert 'errorrrr'

$ ->
  MenuIzqClicked()
  MenuIzqShowProjectClicked()
  $(".volunteer_status").change ->
    $(this).parents("form").submit()
  $('#select_gen').change ->
    event.preventDefault()
    $.get($("#select_gen").attr("action"),
      { select: $("#select_gen").val(), search: $("#inputBuscar").val() }, null, "script");
    false
  $('#select_for_search').change ->
    event.preventDefault()
    $.get($("#select_for_search").attr("action"),
    { aportationType: $("#select_for_search").val(), search: $("#inputBuscar").val() }, null, "script");
    false
  $(document).on 'click', '#adminTable th a', (event) ->
    event.preventDefault()
    $.getScript(this.href)
    false
  $(document).on 'click', '.pagination a', (event) ->
    event.preventDefault()
    $.getScript(this.href)
    false
  $(document).on 'keyup', '#inputBuscar', (event) ->
    $.get($("#inputBuscar").attr("action"),
    {aportationType: $("#select_for_search").val(), select: $("#select_gen").val(),  search: $("#inputBuscar").val()}, null, "script");
    false
  $('.close_alert').click ->
    $('.alert').addClass('hidden')
  $('input#add-images').click ->
    $('.loading-left').removeClass('hidden');




