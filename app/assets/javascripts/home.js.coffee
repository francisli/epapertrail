$ ->
  $('body.home.index').each ->
    
    $('#compare').on 'click', 'a.change-reps', ->
      $compare = $('#compare')
      $compare.find('span.tab, span.separator').show()
      $compare.find('span#compare-senate.tab').addClass('selected')
      $('#compare-results').hide()
      $('#compare-results-content').hide()
      $('#compare-senate-content').show()    
      return false
      
    $('#compare').on 'click', 'a.cancel', ->
      $compare = $('#compare')
      $compare.find('span.tab, span.separator').removeClass('selected').hide()
      $('#compare-results').addClass('selected').show()
      $('#compare-results-content').show()
      $('#compare-senate-content').hide()    
      $('#compare-house-content').hide()    
      return false
      
    reps = new Bloodhound
      name: 'reps',
      datumTokenizer: (d)->
        tokens = []
        tokens.push d['first_name']
        tokens.push d['middle_name']
        tokens.push d['last_name']
        tokens
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch:
        url: '/legislators?chamber=house'
        filter: (parsedResponse)->
          return parsedResponse['results']
    reps.initialize()
      
    senators = new Bloodhound
      name: 'senators',
      datumTokenizer: (d)->
        tokens = []
        tokens.push d['first_name']
        tokens.push d['middle_name']
        tokens.push d['last_name']
        tokens
      queryTokenizer: Bloodhound.tokenizers.whitespace
      prefetch:
        url: '/legislators?chamber=senate'
        filter: (parsedResponse)->
          return parsedResponse['results']
    senators.initialize()
      
    initializeTypeahead = ($input, engine)->
      $input.typeahead null,
        displayKey: (d)->
          "#{d['first_name']} #{d['last_name']} (#{d['party']}-#{d['state']})"
        source: engine.ttAdapter()
      $input.on 'typeahead:selected typeahead:autocompleted', (event, d, dataset)->
        id = $input.attr 'id'
        $("input##{id}_data").val JSON.stringify(d)
        
    initializeCompareForms = ->
      $compare = $('#compare')
      initializeTypeahead $compare.find('input#compare_rep1'), reps
      initializeTypeahead $compare.find('input#compare_rep2'), reps
      initializeTypeahead $compare.find('input#compare_senator1'), senators
      initializeTypeahead $compare.find('input#compare_senator2'), senators
      
    $('#compare').on 'ajax:send', 'form', (event, data, status, xhr)->
      $('#compare .tab-content').hide()
      $('#compare .tabs span').css('visibility', 'hidden')
      $('#compare-content').append('<div class="spinner"></div>')
      
    $('#compare').on 'ajax:success', 'form', (event, data, status, xhr)->
      $('#compare-content').html(data)
      initializeCompareForms()
    
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
    $('#compare-content').load '/compare', ->
      initializeCompareForms()
    