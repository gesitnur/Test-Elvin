$( document ).ready(function() {
  $('.leave-request-form').submit(function(){
    // var request_day = parseInt($('#number-request-day').text())
    // var employee_balance = parseInt($('.employee-balance').text())
    // $('.error-message').text('')
    // $('.hideModalApprove').click(function(){
    //   $(this).parents('#modalLink').fadeOut(100)
    // })

    // if (request_day > employee_balance){
    //   $('#modalLink').fadeIn(200)
    //   $('.error-title').text('Leave balance not enough')
    //   return false;
    // }
    // if (request_day == 0){
    //   $('#modalLink').fadeIn(200)
    //   $('.error-title').text('Leave request period selected is already a holiday')
    //   return false;
    // }
    // if($('.toggle-more-days').is(':checked') && request_day == 1){
    //   $('#modalLink').fadeIn(200)
    //   $('.error-title').text('Please choose another day')
    //   return false;
    // }
  })

  const timeElapsed = Date.now();
  const today = new Date(timeElapsed);

  $('#date-range-filter').daterangepicker({
    "autoApply": true,
    autoUpdateInput: false,
    locale: {
      format: 'DD/MM/YYYY'
    }
  });

  $('#date-range-filter').on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
  });

  $('#date-range').daterangepicker({
    "autoApply": true,
    "minDate": today.toLocaleDateString(),
  });
  $('#date-no-range').daterangepicker({
     singleDatePicker: true,
     "autoApply": true,
    "minDate": today.toLocaleDateString(),
  });

  $('#date-range').change(function(){
    count_request_day()
  })

  $('#date-no-range').change(function(){
    count_single_request_day()
  })

  function count_request_day(){
    var date_range_val = $('#date-range').val().split("-");

    var start_date = new Date(Date.parse(date_range_val[0]));
    var end_date = new Date(Date.parse(date_range_val[1]));

    $('#number-request-day').text(getDatesInRange(start_date, end_date).length)
    $('#number-of-day').val(getDatesInRange(start_date, end_date).length)
  }

  function count_single_request_day(){
    var start_date = new Date(Date.parse($('#date-no-range').val()));
    var end_date = new Date(Date.parse($('#date-no-range').val()));

    $('#number-request-day').text(getDatesInRange(start_date, end_date).length)
    $('#number-of-day').val(getDatesInRange(start_date, end_date).length)
  }

  function getMonth2Digits(date) {
    const month = String(date.getMonth() + 1).padStart(2, '0');

    return month;
  }

  function getDay2Digits(date) {
    const day = String(date.getDate()).padStart(2, '0');

    return day;
  }

  function getDatesInRange(startDate, endDate) {
    const day_date_range = []
    const date = new Date(startDate.getTime());

    while (date <= endDate) {
      var days = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'];
      var holidays = [$('#holiday-list').data('holidays')]

      let day = getDay2Digits(date);
      let month = getMonth2Digits(date);
      let year = date.getFullYear();

      var new_date = day + "/" + month + "/" + year
      var d = new Date(date);
      var dayName = days[d.getDay()];

      if (!holidays[0].includes(new_date)) {
        if ($('#day-list').data('days').includes(dayName)) {
          day_date_range.push(dayName)
        }
      }

      date.setDate(date.getDate() + 1);
    }

    return day_date_range;
  }

  $('.toggle-more-days').change(function(){
    if($(this).is(':checked')){
      $('#date-range').show()
      $('#date-no-range').hide()
      $('.check-input-leave.halfday').prop('disabled', true)
      $('.check-label-leave.halfday').addClass('opacity-70')
      $('#date-no-range').prop('disabled', true)
      $('#date-range').prop('disabled', false)
      count_request_day()
    } else {
      $('#date-range').hide()
      $('#date-no-range').show()
      $('.check-input-leave.halfday').prop('disabled', false)
      $('.check-label-leave.halfday').removeClass('opacity-70')
      $('#date-range').prop('disabled', true)
      $('#date-no-range').prop('disabled', false)
      $('#number-request-day').text(1)
      count_single_request_day()
    }
  })


  $('.check-input-leave').change(function(){
    if($(this).val() === 'halfday'){
      $('#date-range').hide()
      $('#date-no-range').show()
      $('.toggle-more-days').prop('disabled', true)
      $('.toggle-more-days').prop('checked', false)
      $('#date-no-range').prop('disabled', true)
    } else {
      $('.toggle-more-days').prop('disabled', false)
      $('#date-no-range').prop('disabled', false)
    }
  })

  count_request_day()
  count_single_request_day()

  $('.select-type-leave').change(function(){
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: {
        leave_type_id: $(this).val(),
        employee_id: $(this).data('employee-id')
      },
      success: function(data){
        $('.employee-balance').text(JSON.parse(data)['employee_balance'])
      },
      error: function(error){
        console.log("Error:");
      }
    })

  })
});
