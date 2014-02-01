


@ValidarLongitudMaxima = (elemento, longitud) ->
  userName = $(elemento)
  userName.blur ->
    if userName.val().length > longitud
      userName.parent().addClass("has-error")
    else
      userName.parent().removeClass("has-error")

