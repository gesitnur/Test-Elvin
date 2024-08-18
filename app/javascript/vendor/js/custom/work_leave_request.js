$('.copy-link').click(function(){
  $('.copy-link').CopyToClipboard();
  $(this).find('.popuptext').fadeIn(500)
  setTimeout(function(){
    $('.popuptext').fadeOut(900)
  }, 900)
})

$('.group').click(function(){
  $(this).find('nav').addClass('visible opacity-100 translate-y-1').removeClass('invisible opacity-0')
  $(this).parent().parent().siblings().find('.group').find('nav').removeClass('visible opacity-100 translate-y-1').addClass('invisible opacity-0')
})

$('body').click(function(event){
  const ignoreElements = ["group"];
  let pass = true;
  $(ignoreElements).each(function(key, value) {
    if ($(event.target).hasClass(value) || $(event.target).closest(`.${value}`).length > 0) {
      pass = false;
    }
  });
  if (pass) {
    $('.group').find('nav').removeClass('visible opacity-100 translate-y-1').addClass('invisible opacity-0');
  }
});


$('.showModalApprove').click(function(){
  console.log($(this).data('modal'))
  $('#'+$(this).data('modal')).fadeIn(200)
})

$('.hideModalApprove').click(function(){
  $('#'+$(this).data('modal')).fadeOut(100)
})

$('.showModalReject').click(function(){
  $('#'+$(this).data('modal')).fadeIn(200)
})

$('.hideModalReject').click(function(){
  $('#'+$(this).data('modal')).fadeOut(100)
})