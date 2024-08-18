function cash_book_category_click(){
  $('.expense-section').on('click', '.btn-edit-expense', function(e) {
    $(this).parents(".expense-section").find(".update-expense-form").slideDown();
    $(this).parents(".expense-section").find(".expense-data").slideUp();
    $(this).parents(".expense-section").prevAll(".expense-section").find(".update-expense-form").slideUp();
    $(this).parents(".expense-section").prevAll(".expense-section").find(".expense-data").slideDown();
    $(this).parents(".expense-section").nextAll(".expense-section").find(".update-expense-form").slideUp();
    $(this).parents(".expense-section").nextAll(".expense-section").find(".expense-data").slideDown();
  });

  $('.income-section').on('click', '.btn-edit-income', function(e) {
    $(this).parents(".income-section").find(".update-income-form").slideDown();
    $(this).parents(".income-section").find(".income-data").slideUp();
    $(this).parents(".income-section").prevAll(".income-section").find(".update-income-form").slideUp();
    $(this).parents(".income-section").prevAll(".income-section").find(".income-data").slideDown();
    $(this).parents(".income-section").nextAll(".income-section").find(".update-income-form").slideUp();
    $(this).parents(".income-section").nextAll(".income-section").find(".income-data").slideDown();
  });

  $(document).click(function(e){
    var target = e.target
    if(!$(target).is('.update-expense-form') && !$(target).parents().is('.update-expense-form')){
      if($('.expense-data').is(':hidden')){
        $('.expense-data').slideDown()
        $('.update-expense-form').slideUp()
      }
    }
    if(!$(target).is('.update-income-form') && !$(target).parents().is('.update-income-form')){
      if($('.income-data').is(':hidden')){
        $('.income-data').slideDown()
        $('.update-income-form').slideUp()
      }
    }
  })

  // $('.showModal').click(function(){
  //   $(this).parent().find('#modal').fadeIn(200)
  // })
  $('.hideModal').click(function(){
    $(this).parents('#modal').fadeOut(100)
  })
}
export default cash_book_category_click
