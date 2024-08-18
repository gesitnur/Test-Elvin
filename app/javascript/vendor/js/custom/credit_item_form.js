function credit_item_form(){
  $('.record-income').change(function(){
    if($(this).val() == 'yes'){
      $('.record-income-field').show()
    }else{
      $('.record-income-field').hide()
    }
  })
}

export default credit_item_form
