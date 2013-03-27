jQuery ->
  $('body.home.index').each ->
    
    $('#reps').on 'mouseenter', '.portrait', ->
      portrait = $(this)
      unless portrait.hasClass('selected')
        reps = portrait.closest('.reps')
        reps.find('.portrait').removeClass('selected')
        portrait.addClass('selected')
        speeches = reps.next('.speeches')
        speeches.find('.speech').hide()
        speeches.find('.speech[data-bioguide-id=' + portrait.data('bioguide-id') + ']').show()
                