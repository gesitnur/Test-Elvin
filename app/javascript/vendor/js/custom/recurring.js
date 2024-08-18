function change_recurring(){
  $('.select-type-recurring').change(function(){
    if($( ".select-type-recurring option:selected" ).text() == 'Transfer'){
      $('.select-category').hide()
      $('.transfer-section').show()
    }else{
      $('.select-category').show()
      $('.transfer-section').hide()
    }
  })

  if($( ".select-type-recurring option:selected" ).text() == 'Transfer'){
    $('.select-category').hide()
    $('.transfer-section').show()
  }else{
    $('.select-category').show()
    $('.transfer-section').hide()
  }

  $.ajax({
    url: $('.select-transfer-from').data('url'),
    type: "GET",
    dataType:"script",
    data: {
    cash_book_id: $('.select-transfer-from').val()
    },
    success: function(data){
      parent = $('.select-transfer-from').parent();
      parent.find('.transfer-currency').val(JSON.parse(data)['currency_id'])
      if($('#transfer-from-currency').val() == $('#transfer-to-currency').val()){
        $('.transfer-different-currency').addClass("hidden")
        $('.amount-form').removeClass("hidden")
      }else{
        $('.transfer-different-currency').removeClass("hidden")
        $('.amount-form').addClass("hidden")
      }
    },
    error: function(error){
      console.log("Error:");
    }
  })

  $.ajax({
    url: $('.select-transfer-to').data('url'),
    type: "GET",
    dataType:"script",
    data: {
    cash_book_id: $('.select-transfer-to').val()
    },
    success: function(data){
      parent = $('.select-transfer-to').parent();
      console.log("$('#transfer-from-currency').val() == $('#transfer-to-currency').val(")
      console.log($('#transfer-from-currency').val() == $('#transfer-to-currency').val())
      parent.find('.transfer-currency').val(JSON.parse(data)['currency_id'])
      if($('#transfer-from-currency').val() == $('#transfer-to-currency').val()){
        $('.transfer-different-currency').addClass("hidden")
        $('.amount-form').removeClass("hidden")
      }else{
        $('.transfer-different-currency').removeClass("hidden")
        $('.amount-form').addClass("hidden")
      }
    },
    error: function(error){
      console.log("Error:");
    }
  })

  $('.recurring-form').on('change', '.amount-transfer', function(e) {
    $('.transfer-different-currency').val($(this).val())
  })

  $('.recurring-form').on('change', '.select-transfer', function(e) {
    parent = $(this).parent();
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: {
        cash_book_id: $(this).val()
      },
      success: function(data){
        parent.find('.transfer-currency').val(JSON.parse(data)['currency_id'])
        if(($('#transfer-from-currency').val() != $('#transfer-to-currency').val()) && $('#transfer-from-currency').val() != '' && $('#transfer-to-currency').val() != ''){
          $('.transfer-different-currency').removeClass("hidden")
          // alert("$('.transfer-different-currency').removeClass")
          $( ".date-section" ).removeClass( "sm:col-span-1" )
          $('.amount-form').addClass("hidden")
        }else{
          $('.transfer-different-currency').addClass("hidden")
          $( ".date-section" ).addClass( "sm:col-span-1" )
          $('.amount-form').removeClass("hidden")
        }
      },
      error: function(error){
        console.log("Error:");
      }
    })
  })
  $('.recurring-form').submit(function(){
    $('.loading-spinner').css('display', 'inline-block');
    $('.btn-submit-recurring').prop('disabled', true).addClass('opacity-70')
  })
}

export default change_recurring
