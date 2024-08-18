function formatNumber(val){
  return val.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",")
}

function formatCurrency(input, blur){
  var inputVal = input.val()
  if (inputVal === "") { return; }
  var originalLen = inputVal.length
  var caretPos = input.prop("selectionStart")
  if(inputVal.indexOf(".") >=  0){
    var decimalPos = inputVal.indexOf(".")
    var leftSide = inputVal.substring(0, decimalPos)
    var rightSide = inputVal.substring(decimalPos)
    leftSide = formatNumber(leftSide)
    rightSide = formatNumber(rightSide)
    if(blur === "blur"){
      rightSide += "00";
    }
    rightSide = rightSide.substring(0, 2)
    inputVal = leftSide + '.' + rightSide
  } else {
    inputVal = formatNumber(inputVal)
    inputVal = inputVal
    if(blur === "blur"){
      inputVal += ".00"
    }
  }
  input.val(inputVal)
  var updatedLen = inputVal.length
  caretPos = updatedLen - originalLen + caretPos
  input[0].setSelectionRange(caretPos, caretPos)
}

function setValueCurrency(input) {
  var value = input.val()
  if(value != ""){
    var convertToFloat = parseFloat(value)
    var result = convertToFloat.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,')
    input.val(result)
  }
}

function format_number_field(){
  $('.format-currency').on({
    keyup: function(){
      formatCurrency($(this))
    },
    blur: function(){
      formatCurrency($(this), "blur")
    }
  });

  $(".format-currency").each(function() {
      setValueCurrency($(this));
  });
}

$(document).ready(function(){

  // Format Currency Input

  $('.format-currency').on({
    keyup: function(){
      formatCurrency($(this))
    },
    blur: function(){
      formatCurrency($(this), "blur")
    }
  })

  setValueCurrency($('.format-currency'))
});
export default format_number_field
