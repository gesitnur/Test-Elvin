$('.select-country-currency').change(function(){
  $.ajax({
    url: $(this).data('url'),
    type: "GET",
    dataType:"script",
    data: {
      country_id: $(this).val()
    },
    success: function(data){
      $('.symbol-field').val(JSON.parse(data)['symbol'])
      $('.code-field').val(JSON.parse(data)['code'])
    },
    error: function(error){
      $('.symbol-field').val(null)
    }
  })
})

$('.showModalApprove').click(function(){
  $(this).parent().find('#modalApprove').fadeIn(200)
})

$('.hideModalApprove').click(function(){
  $(this).parents('#modalApprove').fadeOut(100)
})
