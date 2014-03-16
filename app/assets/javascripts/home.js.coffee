$ ->
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
                
    $('#reps').on 'click', 'a.not-my-reps', ->
      $reps = $(this).closest('#reps')
      $reps.find('.controls').hide()
      $reps.find('.results').hide()
      $reps.find('form').show()
      return false
                
    $('#reps').on 'click', 'a.cancel', ->
      $reps = $(this).closest('#reps')
      $reps.find('.controls').show()
      $reps.find('.results').show()
      $reps.find('form').hide()
      return false
          
    autocomplete = new google.maps.places.Autocomplete $('input#address').get(0),
      types: [ 'geocode' ]
      
    $('input#address').on 'keydown', (event)->
      if event.keyCode == 13
        event.preventDefault()
      
    google.maps.event.addListener autocomplete, 'place_changed', ->
      placeData = autocomplete.getPlace()
      $('input#address_data').val JSON.stringify(placeData)
      
    $(document).on 'ajax:success', '#my-reps', ->
      $reps = $('#reps')
      $reps.find('.controls').show()
      $reps.find('.results').show()
      $reps.find('form').hide()
      $('#reps .tab-content').empty()
      $('#reps .tab-content').append('<div class="spinner"></div>')
      $('#reps-senate-content').load '/my-reps?chamber=senate'
      $('#reps-house-content').load '/my-reps?chamber=house'
    
    $('#votes-senate-content').load '/latest-votes?chamber=senate'
    $('#votes-house-content').load '/latest-votes?chamber=house'
    $('#reps-senate-content').load '/my-reps?chamber=senate'
    $('#reps-house-content').load '/my-reps?chamber=house'
    $('#compare-content').load '/compare'
    