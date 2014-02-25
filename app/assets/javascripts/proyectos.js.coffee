$ ->
  $('#select_for_search').change ->
    event.preventDefault()
    $.get($("#select_for_search").attr("action"), { aportationType: $("#select_for_search").val(), search: $("#inputBuscar").val() }, null, "script");
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
    $.get($("#inputBuscar").attr("action"), {aportationType: $("#select_for_search").val(), search: $("#inputBuscar").val()} , null, "script");
    false


