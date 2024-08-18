function debt_form(){
  $('.debt-form').submit(function(){
    $('.loading-spinner').css('display', 'inline-block');
    $('.btn-submit-debt').prop('disabled', true).addClass('opacity-70')
  })

  $('.record-income').change(function(){
    if($(this).val() == 'yes'){
      $('.record-income-field').show()
    }else{
      $('.record-income-field').hide()
      $('.record-income-select').val('')
    }
  })
  
  $('.due-input-check').click(function(){
    if($(this).is(':checked')){
      $('.form-group.due-date').slideDown()
    } else {
      $('.form-group.due-date').slideUp()
    }
  })

  $('.select-currency').change(function(){
    find_currency();
  })
  function find_currency(){
    $.ajax({
      url: $('.select-currency').data('url'),
      type: "GET",
      dataType:"script",
      data: {
        currency_id: $('.select-currency').val()
      },
      success: function(data){
        console.log(JSON.parse(data)['currency'])
        // $('.symbol-field').val(JSON.parse(data)['symbol'])
        $(".currency-symbol-text").text(JSON.parse(data)['currency']['symbol']);
      },
      error: function(error){
        // $('.symbol-field').val(null)
        console.log('error')
      }
    })
  }
  find_currency();
}

export default debt_form
