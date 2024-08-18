function category_collection(){
  $.ajax({
    url: $('.select-type').data('url'),
    type: "GET",
    dataType:"script",
    data: {
      type: $('.select-type').val(),
      category: $('.category-id-field').val()
    },
  })
}

$('#transaction-form').on('change', '.select-type', function(e) {
  category_collection();
})

$('.transaction-year-filter').change(function(){
  window.location.replace($(this).data('url')+'?cash_book_id=' + $('#cash_book_id').val() +'&month=' + $('#month').val()+'?&year=' + $('#year').val());
})
