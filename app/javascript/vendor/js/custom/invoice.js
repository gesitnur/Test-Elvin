$('.select-filter-invoice').select2()
$('#btn-set-custom').click(function(){
  $('.form-custom-date').slideDown('slow')
})

$('#btn-close-custom').click(function(){
  $('.form-custom-date').slideUp('slow')
})

$('#btn-filter-custom').click(function(){
  if($('.start-date-input').val() && $('.end-date-input').val() != ''){
    $('.start-date-input').val('')
    $('.end-date-input').val('')
    $('.form-custom-date').slideUp('slow')
  }
})

$('.date-filter').change(function(){
  window.location.replace($(this).data('url')+'?&date_filter=' + $(this).val())
})

function set_item_detail(){
  $.ajax({
    url: $('.select-currency').data('url'),
    type: "GET",
    dataType:"script",
    data: {
      currency_id: $('.select-currency').val()
    },
    success: function(data){
      // $('.symbol-field').val(JSON.parse(data)['symbol'])
      $(".text-total").text("Total ( "+JSON.parse(data)['currency']['symbol']+" )");
    },
    error: function(error){
      // $('.symbol-field').val(null)
      console.log('error')
    }
  })

  var items = []
  $.ajax({
    url: '/user/invoices/item_collection',
    type: "GET",
    async: false,
    dataType:"script",
    data: {
      currency_id: $('.select-currency').val()
    },
    success: function(data){
        console.log('data +-')
        console.log(data)
      items = data
    },
    error: function(error){
      console.log("Error:");
    }
  })

  $( ".select-item-invoice" ).autocomplete({
    minLength: 0,
    source: JSON.parse(items),
    select: function( event, ui ) {
    var parent = $(this).parent().parent().parent();
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: {
        item_id: ui['item']['value']
      },
      success: function(data){
        if (JSON.parse(data)['id'] != null) {
          parent.find('#invoice-name').show();
          parent.find('#invoice-name').prop( "disabled", true );
          parent.find('#invoice-description').show();
        }
        parent.find('#invoice-rate').val(JSON.parse(data)['price']);
        parent.find('#invoice-name').val(JSON.parse(data)['name']);
        parent.find('#invoice-description').val(JSON.parse(data)['description']);
        parent.find('.select-invoice-tax').val(JSON.parse(data)['tax_rate_id']).change();

        rate = parent.find('#invoice-rate').val()
        qty = parent.find('#invoice-qty').val()
        parent.find('#invoice-amount').val((rate * qty).toFixed(2));

        var subtotal = 0
        $('#invoice-items #invoice-amount').each(function(i){
          subtotal += parseInt($(this).val())
        });

        $(".subtotal").text((subtotal).toFixed(2));
        $(".subtotal-field").val((subtotal).toFixed(2));
        count_total()
      },
      error: function(error){
        console.log("Error:");
      }
    })
      $(this).parent().parent().find('.select-item-invoice').hide().val('').prop( "disabled", true );
      $(this).parent().parent().find('.item-name').show()
      $(this).parent().parent().find('.btn-close-item').show()
      $(this).parent().parent().find('.item-name').val(ui.item.label)
      $(this).parent().parent().find('.item-id-field').val(ui.item.value)

      return false;
    },
    open: function(){
      $(".ui-front").css({zIndex: 5});
      $('.ui-autocomplete:visible').css({
        width: "450px",
        maxHeight: "200px",
        overflowY: "auto",
        overflowX: "hidden",
      })
    },
  }).on('focus', function(){ $(this).keydown()});
}

$('.select-currency').change(function(){
  set_item_detail();
})

var items = []
if ($('.select-currency').length != 0) {
  $.ajax({
    url: '/user/invoices/item_collection',
    type: "GET",
    async: false,
    dataType:"script",
    data: {
      currency_id: $('.select-currency').val()
    },
    success: function(data){
        console.log('data +-')
        console.log(data)
      items = data
    },
    error: function(error){
      console.log("Error:");
    }
  })

  $( ".select-item-invoice" ).autocomplete({
    minLength: 0,
    source: JSON.parse(items),
    select: function( event, ui ) {
    var parent = $(this).parent().parent().parent();
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: {
        item_id: ui['item']['value']
      },
      success: function(data){
        if (JSON.parse(data)['id'] != null) {
          parent.find('#invoice-name').show();
          parent.find('#invoice-name').prop( "disabled", true );
          parent.find('#invoice-description').show();
        }
        parent.find('#invoice-rate').val(JSON.parse(data)['price']);
        parent.find('#invoice-name').val(JSON.parse(data)['name']);
        parent.find('#invoice-description').val(JSON.parse(data)['description']);
        parent.find('.select-invoice-tax').val(JSON.parse(data)['tax_rate_id']).change();

        rate = parent.find('#invoice-rate').val()
        qty = parent.find('#invoice-qty').val()
        parent.find('#invoice-amount').val((rate * qty).toFixed(2));

        var subtotal = 0
        $('#invoice-items #invoice-amount').each(function(i){
          subtotal += parseInt($(this).val())
        });

        $(".subtotal").text((subtotal).toFixed(2));
        $(".subtotal-field").val((subtotal).toFixed(2));
        count_total()
      },
      error: function(error){
        console.log("Error:");
      }
    })
      $(this).parent().parent().find('.select-item-invoice').hide().val('').prop( "disabled", true );
      $(this).parent().parent().find('.item-name').show()
      $(this).parent().parent().find('.btn-close-item').show()
      $(this).parent().parent().find('.item-name').val(ui.item.label)
      $(this).parent().parent().find('.item-id-field').val(ui.item.value)

      return false;
    },
    open: function(){
      $(".ui-front").css({zIndex: 5});
      $('.ui-autocomplete:visible').css({
        width: "450px",
        maxHeight: "200px",
        overflowY: "auto",
        overflowX: "hidden",
      })
    },
  }).on('focus', function(){ $(this).keydown()});
}

// $('.select-item-invoice').autocomplete({
//   source: items
// })

$('#invoice-items').on('click', '.btn-close-item', function(e) {
  var parent = $(this).parent().parent();

  $(this).hide()
  parent.parent().find('.item-name').hide()
  parent.parent().find('.select-item-invoice').show()
  parent.parent().find('.select-item-invoice').prop( "disabled", false )
  parent.parent().find('.select-item-invoice').focus()
  parent.parent().find('.select-item-invoice').val("") 

  parent.parent().find('#invoice-rate').val(0);
  parent.parent().find('#invoice-name').val(null);
  parent.parent().find('#invoice-description').val(null);
  parent.parent().find('#invoice-amount').val(0);
  parent.parent().find('.select-invoice-tax').val(null).change();
  var rate = parent.parent().find('#invoice-rate').val()
  qty = parent.parent().find('#invoice-qty').val()
  parent.parent().find('#invoice-amount').val((rate * qty).toFixed(2));

  var subtotal = 0
  $('#invoice-items #invoice-amount').each(function(i){
    subtotal += parseInt($(this).val())
  });
  console.log("subtotal = " + subtotal)
  $(".subtotal").text((subtotal).toFixed(2));
  $(".subtotal-field").val((subtotal).toFixed(2));
  count_total();

})
function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#img_prev')
        .attr('src', e.target.result)
        .width(150)
        .height(200);
    };

    reader.readAsDataURL(input.files[0]);
  }
}

$('.select-invoice-tax').select2();
$('#select-currency').select2()

$('#select-customer').select2().on('select2:open', function () {
  var dataSelect2 = $(this).data('select2');
  if(!$('.select2-link.customer').length){
    dataSelect2.$results.parents('.select2-results').append(
    `
        <a href=`+ $(this).data('customer-url') +` target="_blank" class="text-blue-500 cursor-pointer">
          <div class="select2-link customer p-2 border-t hover:bg-slate-50">
            <i class="fa fa-plus text-lg"></i> New Customer
          </div>
        </a>
      
    `).on('click',function(){
      dataSelect2.trigger('close')
    })
  }
 });


$('#select-sales').select2().on('select2:open', function () {
  var dataSelect2 = $(this).data('select2');
  if(!$('.select2-link.sales').length){
    dataSelect2.$results.parents('.select2-results').append(
    `
        <a href=`+ $(this).data('url') +` target="_blank" class="text-blue-500 cursor-pointer">
          <div class="select2-link sales p-2 border-t hover:bg-slate-50">
            <i class="fa fa-plus text-lg"></i> New Sales Person
          </div>
        </a>
      
    `).on('click',function(){
      dataSelect2.trigger('close')
    })
  }
});
$('#select-term').select2();

$('.attachment-section').on('click', '.btn-delete-attachment', function(e) {
  $( "."+$(this).data('unique') ).remove();
  $(this).parent().remove();
});

$('.invoice-form').on('change', '.upload-multi-file', function(e) {
  const [file] = e.target.files
  var unique_code = Date.now()

  for (var i = 0; i < e.target.files.length; i++)
  {
    if (e.target.files[i].type.includes('image')) {
      var icon = 'fa-file-image'
    }else if (e.target.files[i].type.includes('pdf')) {
      var icon = 'fa-file-pdf'
    }else if (e.target.files[i].type.includes('spreadsheet')) {
      var icon = 'fa-file-excel'
    }else if (e.target.files[i].type.includes('csv')) {
      var icon = 'fa-file-csv'
    }else{
      var icon = 'fa-file'
    }

   $('.attachment-section').append('<div class="mt-4"><i class="fa '+ icon +' m-auto text-pacifixBlue fa-6x" aria-hidden="true"></i><br><span> '+ file.name +' </span><br><span class="btn-delete-attachment" data-unique='+ unique_code +'><i class="fa fa-trash text-slate-300 text-red-400" aria-hidden="true"></i><span>delete</span></span></div>');  
  }

  const form = document.querySelector('.invoice-form');
  var $this = $(this), $clone = $this.clone();
  $this.after($clone)[0].classList.add(unique_code)
  $this.after($clone)[0].classList.add('hidden')
  $this.after($clone)[0].name = 'invoice[attachments_attributes]['+unique_code+'][attachment]'
  $this.after($clone)[0]
  $this.after($clone).appendTo(form);
})
$('#select-customer').change(function(){
  $.ajax({
    url: $(this).data('url'), 
    type: "GET",
    dataType:"script",
    data: {
      customer_id: $(this).val()
    },
  })
})
$('.invoice-date').change(function(){
  $('#select-term').change()
})
$('.due-date').change(function(){
  $('#select-term').val($(this).data('custom-id')).select2('destroy').select2();
})
$('#select-term').change(function(){
  $.ajax({
    url: $(this).data('url'),
    type: "GET",
    dataType:"script",
    data: {
      term_id: $(this).val()
    },
    success: function(data){

      var now = new Date($('.invoice-date').val());

      if (JSON.parse(data)['name'] == 'Due end of the month') {
        var now = new Date(now.getFullYear(), now.getMonth() + 1, 0);
      }else if (JSON.parse(data)['name'] == 'Due end of next month') {
        var now = new Date(now.getFullYear(), now.getMonth() + 2, 0);
      }else{
        now.setDate(now.getDate() + JSON.parse(data)['number_of_day']);
      }

      // var now = new Date();
      // if (now.getMonth() == 11) {
        // var current = new Date(now.getFullYear() + 1, 0, 1);
      // } else {
      // }
      // console.log("lastDayNextMonth = " + lastDayNextMonth)

      console.log("now = " + now)

      var day = ("0" + now.getDate()).slice(-2);
      var month = ("0" + (now.getMonth() + 1)).slice(-2);
      var today = now.getFullYear()+"-"+(month)+"-"+(day) ;
      $('.due-date').val(today);
    },
    error: function(error){
      console.log("Error:");
    }
  })
})
$.ajax({
  url: $('#select-customer').data('url'),
  type: "GET",
  dataType:"script",
  data: {
    customer_id: $('#select-customer').val()
  },
})
$('.btn-add-item').click(function(){
  // $('.select-item-invoice').autocomplete({
  //   source: items
  // })  
  var delayInMilliseconds = 10; //1 second

  setTimeout(function() {
    set_item_detail();
    $('.select-invoice-tax').select2();
  }, delayInMilliseconds);
  
})
$('.remove-existing-attachment').click(function(){
  $('.attachment-'+$(this).data('id')).val(true);
})
$('#discount-field').change(function(){
  $(".discount").text(parseFloat(-Math.abs($(this).val())).toFixed(2));
  count_total()
})
$('#shipping-charges-field').change(function(){
  $(".shipping-charges").text(parseFloat($(this).val()).toFixed(2));
  count_total()
})
$('#adjusment-field').change(function(){
  $(".adjusment").text(parseFloat($(this).val()).toFixed(2));
  count_total()
})

$('#invoice-items').on('click', '.remove-item', function(e) {
  // alert('bbbb');

  var delayInMilliseconds = 10; //1 second

  setTimeout(function() {
    var subtotal = 0;
    $('#invoice-items #invoice-amount').each(function(i){
      subtotal += parseInt($(this).val())
    });

    $(".subtotal").text((subtotal).toFixed(2));
    $(".subtotal-field").val((subtotal).toFixed(2));
    count_total()
  }, delayInMilliseconds);
    
})


$('#invoice-items').on('change', '#invoice-qty', function(e) {
  var parent = $(this).parent().parent();
  var rate = parent.find('#invoice-rate').val()
  parent.find('.select-invoice-tax').change();
  parent.find('#invoice-amount').val((rate * $(this).val()).toFixed(2));
  var subtotal = 0
  $('#invoice-items #invoice-amount').each(function(i){
    subtotal += parseInt($(this).val())
  });

  $(".subtotal").text((subtotal).toFixed(2));
  $(".subtotal-field").val((subtotal).toFixed(2));
  count_total() 
})

$('#invoice-items').on('change', '#invoice-rate', function(e) {
  var parent = $(this).parent().parent();
  var qty = parent.find('#invoice-qty').val()
  parent.find('#invoice-amount').val((qty * $(this).val()).toFixed(2));

  parent.find('.select-invoice-tax').change();
  var subtotal = 0
  $('#invoice-items #invoice-amount').each(function(i){
    subtotal += parseInt($(this).val())
  });

  $(".subtotal").text((subtotal).toFixed(2));
  $(".subtotal-field").val((subtotal).toFixed(2));
  count_total()
})



$('#invoice-items').on('change', '.select-item-invoice', function(e) {
  var parent = $(this).parent().parent().parent();
  // $.ajax({
  //   url: $(this).data('url'),
  //   type: "GET",
  //   dataType:"script",
  //   data: {
  //     item_id: $(this).val()
  //   },
  //   success: function(data){
  //     console.log(JSON.parse(data));
  //     // if (JSON.parse(data)['id'] != null) {
  //     //   parent.find('#invoice-name').show();
  //     //   parent.find('#invoice-name').prop( "disabled", true );
  //     //   parent.find('#invoice-description').show();
  //     // }
  //     parent.find('#invoice-rate').val(JSON.parse(data)['price']);
  //     parent.find('#invoice-name').val(JSON.parse(data)['name']);
  //     parent.find('#invoice-description').val(JSON.parse(data)['description']);
  //     console.log('---------------------------------------');
  //     console.log(JSON.parse(data)['tax_rate_id'] == null)
  //     console.log('---------------------------------------');
  //     parent.find('.select-invoice-tax').val(JSON.parse(data)['tax_rate_id']).change();

      // rate = parent.find('#invoice-rate').val()
      // qty = parent.find('#invoice-qty').val()
      // parent.find('#invoice-amount').val((rate * qty).toFixed(2));

      // var subtotal = 0
      // $('#invoice-items #invoice-amount').each(function(i){
      //   subtotal += parseInt($(this).val())
      // });
      // console.log('Subtotal = ' + subtotal)

  //     $(".subtotal").text((subtotal).toFixed(2));
  //     $(".subtotal-field").val((subtotal).toFixed(2));
  //     count_total()
  //   },
  //   error: function(error){
  //     console.log("Error:");
  //   }
  // })
})

$('#invoice-items').on('change', '.select-invoice-tax', function(e) {
  var parent = $(this).parent().parent();
  var tax = 0;
  $.ajax({
    url: $(this).data('url'),
    type: "GET",
    dataType:"script",
    data: {
      tax_id: $(this).val()
    },
    success: function(data){
      if(JSON.parse(data) != null){
        var amount = parseInt(parent.find('#invoice-amount').val());
        if (amount != 0) {
          tax = amount * JSON.parse(data)['rate'] / 100
        }
        parent.find('#invoice-tax-amount').val(tax.toFixed(2))
      }
      count_total();
    },
    error: function(error){
      console.log("Error:");
    }
  })
})

function count_total(){
  var subtotal = parseInt($('.subtotal').text())
  var discount = Math.abs(parseInt($('.discount').text()))
  var shipping_charges = parseInt($('.shipping-charges').text())
  var adjusment = parseInt($('.adjusment').text())
  
  let tax_field = []

  $('#invoice-items .select-invoice-tax').each(function(i){
    if ($(this).val() != "") {
      var parent = $(this).parent().parent();
      tax_field.push({"name": $('option:selected', this).text(), "value": parseFloat(parent.find('#invoice-tax-amount').val())})      
    }
  });

  var total_tax = 0
  let new_tax_field = tax_field.reduce((acc, curr) => {
    total_tax += curr.value;
    if(acc.some(obj => obj.name === curr.name)) {
      acc.forEach(obj => {
        if(obj.name === curr.name) {
          obj.value = obj.value + curr.value;
        }
      });
    } else {
      acc.push(curr);
    }
    return acc;
  }, []);
  console.log("new_tax_field ")
  console.log(new_tax_field)
  $("#list-tax-section").html("");
  $(new_tax_field).each(function(i, val){
    console.log(val['name']);
    $('#list-tax-section').append(
      `
        <div class="flex items-center justify-between gap-2 mb-2 mt-2">
          <div class="w-full text-left">
            `+val['name']+`
          </div>
          <div class="text-right">
            <span class="text-right">`+ val['value'].toFixed(2) +`</span>
          </div>
        </div>
      `
    )
  })
  var total = subtotal + adjusment + shipping_charges - discount + total_tax
  $(".total").text((total).toFixed(2));
  $(".total-field").val((total).toFixed(2));
}
count_total()
$('.btn-action-dropdown').click(function(){
  $(this).parent().find('.dropdown-action').removeClass('hidden')
  $(this).parent().parent().siblings().children('.action-column').find('.dropdown-action').addClass('hidden')
})

$(document).click(function(e){
  var target = e.target
  if(!$(target).is('.btn-action-dropdown') && !$(target).parents().is('.btn-action-dropdown')){
    $('.dropdown-action').addClass('hidden')
  }
})
