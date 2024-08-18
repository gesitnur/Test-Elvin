$('#btn-copy-address').click(function() {
  $('#shipping-attention').val($('#billing-attention').val());
  $('#shipping-country').val($('#billing-country').val());
  $('#shipping-street1').val($('#billing-street1').val());
  $('#shipping-street2').val($('#billing-street2').val());
  $('#shipping-state').val($('#billing-state').val());
  $('#shipping-city').val($('#billing-city').val());
  $('#shipping-zip-code').val($('#billing-zip-code').val());
  $('#shipping-phone').val($('#billing-phone').val());
  $('#shipping-fax').val($('#billing-fax').val());
})

var displayName = []
$('#salutation, #first-name, #last-name, #company-name').bind('blur', function(){
  var displayName = []
  if ($('#first-name').val() != '' && $('#last-name').val() != '') {
    var values = $('#first-name').val() +' '+ $('#last-name').val()
    displayName.push(values)
    var values =  $('#last-name').val() +', '+ $('#first-name').val()
    displayName.push(values)
  }

  if ($('#first-name').val() != '' && $('#last-name').val() != '' && $('#salutation').val() != '') {
    var values = $('#salutation').val() +' '+ $('#first-name').val() +' '+ $('#last-name').val()
    displayName.push(values)
  }

  if ($('#first-name').val() != '' && $('#salutation').val() != '') {
    var values = $('#salutation').val() +' '+ $('#first-name').val()
    displayName.push(values)
  }

  if ($('#last-name').val() != '' && $('#salutation').val() != '' && $('#first-name').val() == '') {
    var values = $('#salutation').val() +' '+ $('#last-name').val()
    displayName.push(values)
  }

  if ($('#first-name').val() != '' && $('#salutation').val() == '') {
    var values = $('#first-name').val()
    displayName.push(values)
  }

  if ($('#last-name').val() != '' && $('#first-name').val() == '') {
    var values = $('#last-name').val()
    displayName.push(values)
  }

  if ($('#company-name').val() != '') {
    var values =  $('#company-name').val()
    displayName.push(values)
  }
  $('#display-name').autocomplete({
  minLength: 0,
  source: displayName,
}).on('focus', function(){ $(this).keydown()})

})

$('#salutation').change(function(){
  displayName.splice(0, 2, $(this).val())
  displayName.shift()
})

$('#first-name').bind('blur', function(){
  displayName.splice(1, 0, $(this).val())
  displayName.shift()
})
$('#last-name').bind('blur', function(){
  displayName.splice(2, 0, $(this).val())
  displayName.shift()
})

$('#display-name').autocomplete({
  minLength: 0,
  source: displayName,
}).on('focus', function(){ $(this).keydown()})
