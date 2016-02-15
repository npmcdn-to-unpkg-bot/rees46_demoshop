$( document ).on("last-element-rendered", function() {
  $('#product_industry').on('change', function() {
    var industry = $(this).val();
    if (industry === "Fashion") {
      $(".country-sizes, .group-sizes").addClass('hidden');
      $('#fashion-param, #gender').removeClass('hidden');
    } else if (industry === "Cosmetic") {
      $(".country-sizes, .group-sizes").addClass('hidden');
      $('#cosmetic-param, #gender, #periodic').removeClass('hidden');
    } else if (industry === "Child") {
      $(".country-sizes, .group-sizes").addClass('hidden');
      $('#gender, #child_sizes, #child-param').removeClass('hidden');
    }
  });


  // This is for product size
  $('[name="product[size]"]').on('change', function() {
    $(".group-sizes").addClass('hidden');
    $('#pro-' + $(this).attr('id')).removeClass('hidden');
  });

  // This is for product child size
  $('[name="product[child_sizes]"]').on('change', function() {
    $(".child_group_sizes").addClass('hidden');
    $('#chi-' + $(this).attr('id')).removeClass('hidden');
  });

  // Show child/adult size & Periodic when type have sizes/Periodic
  $('[name="product[type]"]').on('change', function() {
    var value = $(this).val();
    if (['18', '19', '9','0','1','2','3','4','5'].indexOf(value) > -1) {
      $('#size-types').removeClass('hidden');
    } else if (['12', '13'].indexOf(value) > -1) {
      $('#periodic, #size-types').removeClass('hidden');
    } else if (value) {
      $(".child_group_sizes, .group-sizes, .country-sizes-types, .country-periodic").addClass('hidden');
    }
  });
});
