$ ->
  $('body.reps.show').each ->
    $('#rep-floor-content').load $('#rep-floor-content').data('href')
    $('#rep-bills-content').load $('#rep-bills-content').data('href')
    $('#rep-votes-against-content').load $('#rep-votes-against-content').data('href')
    