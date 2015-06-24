$ ->
  $('body.bills.show').each ->
    $('#bill-summary-content').load $('#bill-summary-content').data('href'), ->
      enableColumnScrolling $('#bill-summary-content')
