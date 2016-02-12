$( document ).on("last-element-rendered", function() {
  $('#product_industry').on('change', function() {
    var industry = $(this).val();
    if (industry === "Fashion") {
      $(".country-sizes, .group-sizes").addClass('hidden');
      $('#fashion-param, #gender, #size-types').removeClass('hidden');
    } else if (industry === "Cosmetic") {
      $(".country-sizes, .group-sizes").addClass('hidden');
      $('#cosmetic-param, #gender, #periodic').removeClass('hidden');
    } else if (industry === "Child") {
      $(".country-sizes, .group-sizes").addClass('hidden');
      $('#child-param, #gender, #periodic').removeClass('hidden');
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
    $('#pro-' + $(this).attr('id')).removeClass('hidden');
  });
});
