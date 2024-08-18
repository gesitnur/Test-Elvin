$(document).ready(function(){
  $('#domain-access-field').change(function(){
    var data_form = $("#search-contact-form").serialize()
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: data_form,
    })
  });

  $('#admin-domain-access-field').change(function(){
    var data_form = $("#search-admin-form").serialize()
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: data_form,
    })
  });

  const sidebar = $('.sidebar')
  const toggle = $('.navbar-toggle');
  const userProfileDropdown = $('.user-profile')
  const duration = $('.duration');
  const hrdNotes = $('#hrd-notes');

  var id_name_bill_to    = 'customer_bill_to_name';
  var id_address_bill_to = 'customer_bill_to_address';
  var id_name_ship_to   = 'customer_ship_to_name';
  var id_address_hip_to = 'customer_ship_to_address';

  toggle.click(function(){
    sidebar.toggleClass('active')
  })

  $('body').click(function(event){
    const ignoreElements = ["navbar-toggle", "sidebar", "user-profile-menu", "user-profile", "btn-action-dropdown", "button-action"];
    let pass = true;
    $(ignoreElements).each(function(key, value) {
      if ($(event.target).hasClass(value) || $(event.target).closest(`.${value}`).length > 0) {
        pass = false;
      }
    });
    if (pass) {
      $('.sidebar').removeClass('active');
      $('.dropdown-action').addClass('hidden')
      $('.user-profile-menu').addClass('hidden')
    }
  });

  // on focus menu link
  $('.sidebar-menu-link').each(function(){
    if($(this).hasClass('active')){
      $(this).focus()
    }
  })

  userProfileDropdown.click(function(){
    $('.user-profile-menu').toggleClass('hidden')
  })

  duration.attr('disabled', true);
  $('#check-training').click(function(){
    $('#training-duration').toggleClass('bg-slate-100')
    if($(this).is(':checked')){
      $('#training-duration').removeAttr('disabled');
      $('#training-duration').focus();
    } else {
      $('#training-duration').attr('disabled', 'disabled');
    }
  });
  $('#check-trial').click(function(){
    $('#trial-duration').toggleClass('bg-slate-100');
    if($(this).is(':checked')){
      $('#trial-duration').removeAttr('disabled');
      $('#trial-duration').focus();
    } else {
      $('#trial-duration').attr('disabled', 'disabled');
    }
  });

  duration.keypress(function(){
    if (this.value.length == 2) {
      return false;
    }
  });

  hrdNotes.trumbowyg({
    svgPath: 'https://raw.githubusercontent.com/Alex-D/Trumbowyg/main/dist/ui/icons.svg',
    resetCss: true,
    btns: [
      ['undo', 'redo'], // Only supported in Blink browsers
      ['formatting'],
      ['strong', 'em', 'del'],
      ['link'],
      ['insertImage'],
      ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'],
      ['unorderedList', 'orderedList'],
      ['horizontalRule'],
      ['fullscreen']
    ]
  });

  // const pre = $('pre');

  // pre.litelighter({
  //   clone: true,
  //   language: 'css'
  // });

  $('#domain-access-field').change(function(){
    var data_form = $("#search-contact-form").serialize()
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: data_form,
    })
  });

  $('#admin-domain-access-field').change(function(){
    var data_form = $("#search-admin-form").serialize()
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: data_form,
    })
  });

  $('.service-field').select2({
    placeholder: "Please Choose",
    width: '100%',
  });

  $('#checkbox_bill_to').click(function() {
    var value   = $(this).is(':checked');
    var name    = $('#customer_name_name').val();
    var address = $('#customer_name_address').val();

    if (value) {
      updateField(name, address, id_name_bill_to, id_address_bill_to);
      if ($('#checkbox_ship_to').is(':checked')) {
        updateField(name, address, id_name_ship_to, id_address_hip_to );
      }
    } else {
      updateField('', '', id_name_bill_to, id_address_bill_to);
      updateField('', '', id_name_ship_to, id_address_hip_to);
    }
  })

  $('#checkbox_ship_to').click(function() {
    var value   = $(this).is(':checked');
    var name    = $('#customer_bill_to_name').val();
    var address = $('#customer_bill_to_address').val();

    if (value) {
      updateField(name, address, id_name_ship_to, id_address_hip_to);
    } else {
      updateField('', '', id_name_ship_to, id_address_hip_to);
    }
  })

  function updateField(name_value, address_value, id_name, id_address) {
    $(`#${id_name}`).val(name_value);
    $(`#${id_address}`).val(address_value);
  }

  $('.dropdown-button').click(function(){
    $(this).parents('.sidebar-menu-wrap').find('.dropdown').slideToggle('slow')
    $(this).children('.arrow-dropdown').toggleClass('active')
    $(this).parents('.sidebar-menu-wrap').siblings('.sidebar-menu-wrap').find('.dropdown').slideUp('slow')
    $(this).parents('.sidebar-menu-wrap').siblings('.sidebar-menu-wrap').find('.arrow-dropdown').removeClass('active')
  })

  $('#tabs-nav li:first-child').addClass('active');
  $('.tab-content').hide();
  $('.tab-content:first').show();

  // Click function
  $('#tabs-nav li').click(function(){
    $('#tabs-nav li').removeClass('active');
    $(this).addClass('active');
    $('.tab-content').hide();
    var activeTab = $(this).find('a').attr('href');
    $(activeTab).fadeIn(600);
    return false;
  });

  $('#tabs-nav-forum li').click(function(){
    $('#tabs-nav-forum li').removeClass('active');
    $(this).addClass('active');
  });

  $('.select-dropdown').select2({
    width: '100%',
  })

  $(document).keyup(function(e) {
    if (e.key === "Escape") { // escape key maps to keycode `27`
        $('.modal').fadeOut(100)
    }
  });

  $('#gameplay').select2({
    placeholder: "Pilih Assesment",
    width: '100%',
    allowClear: true,
  })

  $('.modal.income').hide()
  $('.modal.expense').hide()
  $('.btn-modal-income').click(function(){
    var delayInMilliseconds = 300; //1 second

    setTimeout(function() {
      $('.modal.income').slideDown('slow')
      $('.modal.expense').hide()
    }, delayInMilliseconds);
  })

  $('body').on('click', '.btn-close', function(e) {
    $('.modal').slideUp('slow')
  })

  $('.btn-close-alert').click(function(){
    $(this).parent().fadeOut()
  })

  $('body').on('click', '.showModal', function(e) {
    $(this).parent().find('#modal').fadeIn(200)
    $(this).parents('body').css("overflow", "hidden")
    $('.navbar').addClass('z-10').removeClass('z-30')
  })

  $('body').on('click', '.hideModal', function(e) {
    $(this).parents('#modal').fadeOut(200)
    $(this).parents('body').css("overflow", "auto")
    $('.navbar').addClass('z-30').removeClass('z-10')
  })

  $('.btn-add-question-essays').hide()
  $('#btn-quest-essays').show()
  $('#btn-quest-multiples').hide()
  $('#btn-quest-multiples').click(function(){
     $('.btn-add-question-essays').hide()
     $('.btn-add-question-multiples').show()
     $(this).hide()
     $('#btn-quest-essays').show()
  })
  $('#btn-quest-essays').click(function(){
     $('.btn-add-question-essays').show()
     $('.btn-add-question-multiples').hide()
     $(this).hide()
     $('#btn-quest-multiples').show()
  })

  $('.correct-answer-label').hide()
  $('.correct-answer-radio').click(function(){
    if($(this).prop("checked", true).val() == 'option_1'){
      $('#label_option_1').show()
      $('#label_option_2').hide()
      $('#label_option_3').hide()
      $('#label_option_4').hide()
    } else if($(this).prop("checked", true).val() == 'option_2'){
      $('#label_option_1').hide()
      $('#label_option_2').show()
      $('#label_option_3').hide()
      $('#label_option_4').hide()
    } else if($(this).prop("checked", true).val() == 'option_3'){
      $('#label_option_1').hide()
      $('#label_option_2').hide()
      $('#label_option_3').show()
      $('#label_option_4').hide()
    } else if($(this).prop("checked", true).val() == 'option_4'){
      $('#label_option_1').hide()
      $('#label_option_2').hide()
      $('#label_option_3').hide()
      $('#label_option_4').show()
    }
  })

  function updateQuestion(){
    if($('.is-basic:checked').val() == 'true'){
      $('.form-check-input').attr('disabled', true);
      $('.point-question').attr('disabled', true);
      $('.correct-answer-section').addClass('text-slate-300');
      $('.point-label').addClass('text-slate-300');
      $(".correct-answer-radio").prop('required', false);;
      $('.point-question').val(0);
      $(".point-question").attr({
       "min" : 0
      });
    }
    else{
      $(".correct-answer-radio").prop('required', true);
      $('.correct-answer-section').removeClass('text-slate-300');
      $('.point-label').removeClass('text-slate-300');
      $('.form-check-input').attr('disabled', false);
      $('.point-question').attr('disabled', false);
      $(".point-question").attr({
        "min" : 1
      });
    }
  }

  $('.btn-add-question').click(function(){
    setTimeout(
    function()
    {
      updateQuestion();
    }, 100);
  });

  $('.is-basic').change(function () {
    updateQuestion();
  });

  $('.btn-next').click(function(event){
    var current_section = $('.active-section').data('key')
    var all_radio_input = $('.radio-section-' + current_section).length;
    var option_field = '.radio-field-' + current_section
    var next_key = (current_section + 1);

    var essay_field = $('.essay-field-' + current_section).filter(function() {
      return this.value == ''
    });

    if($(option_field + ':checked').length == all_radio_input && essay_field.length == 0){
      event.preventDefault();
      var last_gameplay = $(this).data('last-gameplay');

      if(next_key == last_gameplay){
        $('.btn-submit').show();
        $('.btn-next').hide();
      }

      $('.container').hide();
      $ ('.gameplay-'+ next_key ).show();
      $( ".gameplay-" + current_section ).removeClass( "active-section" )
      $( ".gameplay-" + next_key ).addClass( "active-section" )


      $('html,body').animate({ scrollTop: 0 }, 'slow');
    }
  });

  $('.submit-button').click(function(){
    var multiple_choice_field = $('.multiple-choice-field').filter(function() {
      return this.value == ''
    });
    if (multiple_choice_field.length > 0) {
      change_active_question('#tab-multiple-choice');
    }

    var essay_field = $('.essay-field').filter(function() {
      return this.value == ''
    });
    if (essay_field.length > 0) {
      change_active_question('#tab-essay');
    }
    if($('.is-basic:checked').val() == 'false'){
      var multiple_choice_point = $('.multiple-choice-point').filter(function() {
        return this.value == 0
      });
      if (multiple_choice_point.length > 0) {
        change_active_question('#tab-multiple-choice');
      }
      var essay_point = $('.essay-point').filter(function() {
        return this.value == 0
      });
      if (essay_point.length > 0) {
        change_active_question('#tab-essay');
      }
    }
  });
  $('.btn-quest').click(function(){
    change_active_question('#'+$(this).data('section'));
  });

  function change_active_question(section){
    $('.quest-section').addClass("hidden");
    $(section).removeClass("hidden");
    $(section).addClass("block");
  }

  if($('.report-section').length == 0){
    $('.empty-data-section').show();
  }

  $('.filter-date').change(function(){
    window.location.replace($(this).data('url')+'?date=' + $('#select-cash-report-date').val()+'&currency_id=' + $('#select-cash-report').val());
  })

  updateQuestion();

  $('.categories-name').click(function(){
    $('.'+$(this).data('check')).fadeToggle()
  })

  $('.year-filter').change(function(){
    window.location.replace($(this).data('url')+'?currency_id=' + $('#select-cash-report').val() +'&month=' + $('#month').val()+'&year=' + $('#year').val());
  })

  $('.filter-annually').change(function(){
    window.location.replace($(this).data('url')+'?year=' + $('#select-cash-report-date').val()+'&currency_id=' + $('#select-cash-report').val());
    })

  $('.input-range').on('input', function(){
    $(this).parent().parent().find('.output-range p').html(this.value);
  })

  $('#survey_form').on('click', '.btn-add-survey-option', function(){
    $(this).parent().find('.btn-remove-option').show()
    var length = $(this).parent().find('.option-field').length

    if (length == 9) {
      $(this).prop('disabled', true)
    }

    var new_option_field = $(this).parent().find('.form-custom-item').last().clone()

    new_option_field.each(function() {
      var input_field = $(this).find('input')[0].name
      var new_field_number = (parseInt(input_field.substr(input_field.length - 3).substring(0, 1)) + 1)

      $(this).find('input')[0].name= $(this).find('input')[0].name.replace(/.{0,3}$/, '') + (new_field_number) + ']]';
      $(this).find('input')[0].value = null
    });

    new_option_field.hide()
    $(new_option_field).appendTo( $(this).parent().find('.option-section') ).slideDown()
  })


  var index = 0;
  $('.btn-add-option').click(function(){
    const elementOption = `
      <div class="form-custom-item flex items-center gap-3 mb-2" style="display: none;">
        <input type="text" id="form-check-input" placeholder="Option" class="w-full sm:w-1/2 border h-9 px-2 roundedo outline-none focus:border-pacifixBlue transition ease-in">
        <button class="btn-remove-option text-gray-500"><i class="fa fa-times" aria-hidden="true"></i></button>
      </div>
    `
    if(index < 9){
      $(elementOption).appendTo('.form-custom-list').slideDown()
      index++
    } else {
      $(this).prop('disabled', true)
    }
  })

  $('.main-content-form').on('change', '.select-survey-type', function(){
    if($(this).val() === 'custom option'){
      $(this).parents('.main-content-card').find('.form-custom-option').slideDown()
    } else {
      $(this).parents('.main-content-card').find('.form-custom-option').slideUp()
    }
  })

  $('.select-navigation-question').on('change',function(){
    let questionList = [];
    let selectedQuestion = $('.select-navigation-question')

    $('.main-content-card-question').each(function(index){
      questionList.push({
        index: index,
        value: $(this).attr('id')
      })
      if('#'+selectedQuestion.val() === "#"+questionList[index].value) {
        var getPositionElement = $(this).offset().top
        if(selectedQuestion.children().last().index() == index + 1){
          $("html, body").animate({ scrollTop: getPositionElement - 275}, 1000);  
        } else {
          $("html, body").animate({ scrollTop: getPositionElement - 150}, 1000);
        }
        return false;
      }
    })
  })

  $('#survey_form').on('click', '.btn-remove-option', function(){
    $(this).parent().slideUp()
    $(this).parent().parent().parent().find('.btn-add-survey-option').prop('disabled', false)

    var delayInMilliseconds = 500; //1 second
    parent = $(this).parent()

    setTimeout(function() {
      var next_parent = parent.parent()
      parent.remove()
      var length = next_parent.find('.form-custom-item').length

      if (length == 2){
        next_parent.find('.form-custom-item').first().find('.btn-remove-option').hide()
        next_parent.find('.form-custom-item').first().next().find('.btn-remove-option').hide()
      }

    }, delayInMilliseconds);
  })

  $('#survey_form').on('change', '.select-survey-type', function(){
    if($(this).val() === 'Custom Option'){
      $(this).parent().parent().parent().find('.form-custom-option').slideDown()
    } else {
      $(this).parent().parent().parent().find('.form-custom-option').slideUp()
    }
  })

  function updateNumberQuestion(){
    setTimeout(()=>{
      $('.main-content-card-question').each(function(i){
        var element = $(this)
        element.find('.main-content-number > p').text(i+1+".")
        element.attr('id', `question-${i+1}`)
      })
    }, 1)
  }

  function addOptionQuestion(){
    $('.select-navigation-question').children().each(function(i){
      var element = $(this)
      element.not(':nth-child(1)').text("Question "+i).val('question-'+i)
    })
  }

  function removeOption(element){
    element.last().remove()
  }

  $('.main-content-card-question').each(function(){
     $('.select-navigation-question').append(
        `<option></option>`
      )
     addOptionQuestion()
  })
  updateNumberQuestion()

  $('#survey_form').on('click', '.btn-add-survey-question', function(){
    updateNumberQuestion()
    $('.select-navigation-question').append(
        `<option></option>`
      )
    addOptionQuestion()
    $("html, body").animate({ scrollTop: $('#survey_form').prop('scrollHeight') }, 1500);
  })

  $('#survey_form').on('click', '.btn-remove-survey-question', function(){
    removeOption($('.select-navigation-question').children())
    updateNumberQuestion()
  })

  $('.btn-upvote').each(function(i){
    var active = false
    var $this = $(this).attr('data-upvote', `button-upvote-${i+1}`)
    $this.click(function(){
      active = !active
      var totalUpvote = parseInt($this.parent().parent().find('.total-upvote').text());
      if(active){
        var modifiedVote = totalUpvote + 1
        $this.parent().find('.total-upvote').text(modifiedVote)
        $this.addClass('border-pacifixBlue')
        $this.addClass('text-pacifixBlue')
        $this.parent().siblings().addClass('border-pacifixBlue')
      } else {
        var modifiedVote = totalUpvote - 1
        $this.parent().find('.total-upvote').text(modifiedVote)
        $this.removeClass('border-pacifixBlue')
        $this.removeClass('text-pacifixBlue')
        $this.parent().siblings().removeClass('border-pacifixBlue')
      }
    })
  })

  $('.filter-currency').select2();

  $('.btn-help-center-reply').click(function(){
    $(this).parents('.help-center-action').find('.editor').slideToggle()
  })

  $('.btn-replies').click(function(){
    $(this).parents().find('.editor').slideToggle()
  })

  $('.btn-submit-reply').click(function(){
    setTimeout(()=>{
      $(this).parent().find('.trumbowyg-editor').empty()
    }, 1000)
  })

  $('body').on('click', '.btn-edit-reply', function(e) {
    var $this = $(this)
    $this.parents('.reply-item').find('.editor').slideToggle()
    $this.parents('.reply-item').find('.reply-detail').slideToggle()
  })

  $('body').on('click', '.btn-delete-reply', function(e) {
    $(this).parents('.reply-item').find('#modal').fadeIn(200)
    $(this).parents('body').css("overflow", "hidden")
  })

  $('.text-editor').trumbowyg({
    svgPath: 'https://raw.githubusercontent.com/Alex-D/Trumbowyg/main/dist/ui/icons.svg',
    btns: [
      ['undo', 'redo'], // Only supported in Blink browsers
      ['formatting'],
      ['strong', 'em', 'del'],
      ['link'],
      ['insertImage'],
      ['justifyLeft', 'justifyCenter', 'justifyRight', 'justifyFull'],
      ['unorderedList', 'orderedList'],
      ['horizontalRule'],
      ['fullscreen']
    ]
  });

  $('.img-box-company').click(function() {
    $('#imgInp').trigger('click')
  })

  var input2 = document.querySelector(".tagify-field");
  new Tagify(input2, {
    whitelist : ['Dashboard', 'Position', 'Worker', 'Leave Request', 'Interview', 'Gameplay', 'Invoice', 'Item'
                  , 'Customer', 'Tax', 'Sales Person', 'Payment Tearm', 'Currency', 'Cash Book', 'Cash Book Category'
                  , 'Debt', 'Credit', 'Cash Report', 'Settting'],
    maxTags : 5
  });

  $('body').on('change', '.sort-question', function(e) {
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: {
        sort: $(this).val()
      },
    })
  })

  $('body').on('click', '.btn-sort-reply', function(e) {
    $.ajax({
      url: $(this).data('url'),
      type: "GET",
      dataType:"script",
      data: {
        sort: $(this).data('sort')
      },
    })
  })

  $('body').on('click', '#btn-import-holiday', function(e) {
    $('.import-modal').fadeIn(200)
     $(this).parents('body').css('overflow', 'hidden')
  })

  $('body').on('click', '#btn-add-holiday', function(e) {
    console.log('#btn-add-holiday')
    $('.add-modal').fadeIn(200)
     $(this).parents('body').css('overflow', 'hidden')
  })

  $('.hideModal').click(function(){
    $(this).parents('#modal').fadeOut(100)
    $("#title").val("")
    $("#start-date").val("")
    $("#end-date").val("")
    $(this).parents('body').css('overflow', 'auto')
  })

  window.onclick = function(event) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }

  var events = []
  var working_day = []
  // $.ajax({
  //   url: $('#holiday-url').data('url'),
  //   type: "GET",
  //   async: false,
  //   dataType:"script",
  //   success: function(data){
  //     events = JSON.parse(data)['convert_holidays']
  //     working_day = JSON.parse(data)['working_day']
  //     working_day = String(working_day)
  //   },
  //   error: function(error){
  //     console.log("Error:");
  //   }
  // })
  var calendarEl = document.getElementById('company-calendar');
  var daySelected = working_day
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    eventTimeFormat:  {
      hour: 'numeric',
      minute: '2-digit',
      meridiem: 'short'
    },

    businessHours: {
      daysOfWeek: daySelected,

      startTime: '08:00',
      endTime: '17:00',
    },
    eventClick: function (info) {
      $('#showModalHoliday').trigger('click')
    },
    headerToolbar: {
      left: 'prev,today,next addHoliday',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay'
    },
    buttonText: {
      today: 'Today',
      month: 'Month',
      week: 'Week',
      day: 'Day',
    },
    customButtons: {
      addHoliday: {
        text: 'Add Holiday',
        click: function() {
          $('#showModalHoliday').trigger('click')
        }
      },
    },

    dayMaxEventRows: true,
    views: {
      timeGrid: {
        dayMaxEventRows: 1
      }
    },
    events: events,
    eventClick: function (info) {
      $.ajax({
        url: $('#leave-link').data('url'),
        type: "GET",
        dataType:"script",
        data: {
          id: info.event.id
        },
        success: function(data){
          
        },
        error: function(error){
          // console.log("Error:");
        }
      })
      return false;
    },
  });
  calendar.render();

  $(".fc-addHoliday-button").wrap('<div class="group relative inline-block"></div>')
  $(".fc-addHoliday-button").parent().append(`<div class="dropdown import-holiday-dropdown tooltip">
  <span class="tooltip-text bg-gray-500 shadow text-white -bottom-10 left-0 rounded whitespace-nowrap">
  Add Company Holiday</span>
  <button onclick="myFunction()" class="dropbtn fc-button fc-button-primary"><i class=" fas fa-plus"></i></button>
  <div id="myDropdown" class="dropdown-content w-48">
    <a class="block px-4 py-2 hover:bg-gray-100 text-[#4f4f4f] cursor-pointer" id="btn-add-holiday">
                      <span><i class="fa fa-plus w-7" aria-hidden="true"></i> Add Holiday</span>
    <a class="block px-4 py-2 hover:bg-gray-100 text-[#4f4f4f] cursor-pointer" id="btn-import-holiday">
                      <span><i class="fa fa-upload w-7" aria-hidden="true"></i> Import Holidays</span>
    </a></div></div>`);
  $(".fc-addHoliday-button").hide()

  imgInp.onchange = evt => {
    const [file] = imgInp.files
    if (file) {
      blah.src = URL.createObjectURL(file)
    }
  }
})
