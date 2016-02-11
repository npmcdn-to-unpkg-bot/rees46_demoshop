$( document ).on("last-element-rendered", function() {
  $('#product_industry').on('change', function() {
    var industry = $(this).val();
    if (industry === "fashion") {
      $(".country-sizes, .group-sizes").addClass('hidden');
      $('#fashion-param, #gender, #size-types').removeClass('hidden');
    } else if (industry === "cosmetic") {
      $(".country-sizes, .group-sizes").addClass('hidden');
      $('#cosmetic-param, #gender').removeClass('hidden');
    } else if (industry === "kids") {
      $(".country-sizes, .group-sizes").addClass('hidden');
      $('#kids-param , #gender, #size-types, #periodic').removeClass('hidden');
    }
  });

  $('[name="product[size]"]').on('change', function() {
    $(".group-sizes").addClass('hidden');
    $('#pro-' + $(this).attr('id')).removeClass('hidden');
  });
});
