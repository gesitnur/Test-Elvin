$('.select-deposit').select2();
  // select-deposit

  $.ajax({
    url: $('.select-deposit').data('url'),
    type: "GET",
    dataType:"script",
    data: {
    cash_book_id: $('.select-deposit').val()
    },
    success: function(data){
      $('.deposit-currency').val(JSON.parse(data)['currency_id']);
    },
    error: function(error){
      console.log("Error:");
    }
  })

  $('.select-deposit').change(function(){
    $.ajax({
      url: $('.select-deposit').data('url'),
      type: "GET",
      dataType:"script",
      data: {
      cash_book_id: $('.select-deposit').val()
      },
      success: function(data){
        $('.deposit-currency').val(JSON.parse(data)['currency_id']);
      },
      error: function(error){
        console.log("Error:");
      }
    })
  })

  if ($('.amount-received-field').val() == $('.invoice-amount-field').val() && $('.deposit-currency').val() == $('.invoice-currency').val()) {
    $('#payment_mode').prop('checked', false);
  }else {
    $('#payment_mode').prop('checked', true);
  }

  $('.amount-received-field').change(function(){
    var invoice_amount = parseFloat($('.invoice-amount-field').val().replace(/,/, '')).toFixed(2)
    var amount_received = parseFloat($(this).val().replace(/[^0-9.-]+/g,"")).toFixed(2) //regex for parse the numbers

    if (amount_received == invoice_amount && $('.deposit-currency').val() == $('.invoice-currency').val()) {
      $('#payment_mode').prop('checked', false);
      $('#payment_mode').prop('disabled', true);
    }else {
      $('#payment_mode').prop('checked', true);
      $('#payment_mode').prop('disabled', false);
    }
  })