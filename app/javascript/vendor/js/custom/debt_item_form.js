function debt_item_form(){
  $('.debt-item-form').submit(function(){
    $('.loading-spinner').css('display', 'inline-block');
    $('.btn-submit-debt').prop('disabled', true).addClass('opacity-70')
  })

  $('.record-income').change(function(){
    if($(this).val() == 'yes'){
      $('.record-income-field').show()
    }else{
      $('.record-income-field').hide()
    }
  })
}

export default debt_item_form
