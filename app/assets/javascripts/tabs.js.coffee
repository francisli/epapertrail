jQuery ->
  
  $(document).on 'mouseenter', 'span.tab', ->
    $(this).addClass('hover')
    
  $(document).on 'mouseleave', 'span.tab', ->
    $(this).removeClass('hover')
  
  $(document).on 'click', 'span.tab', ->
    tab = $(this)
    tabs = tab.closest('.tabs')
    tabs.find('span.tab').removeClass('selected')
    tab.addClass('selected')
    contents = tabs.nextAll('.tabs-content')
    contents.find('.tab-content').hide()
    contents.find('#' + tab.attr('id') + '-content').show()
    