$( document ).ready(function() {
  $('#product_industry').on('change', function() {
    var industry = $(this).val();
    if (industry === "fashion") {
      $('#fashion-param').removeClass('hidden');
    }
  });

  $('#product_size_russian_size').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "russian_size") {
      $('#size-ru-param').removeClass('hidden');
    }
  });

  $('#product_size_euro_size').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "euro_size") {
      $('#size-eu-param').removeClass('hidden');
    }
  });

  $('#product_size_american_size').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "american_size") {
      $('#size-us-param').removeClass('hidden');
    }
  });

  $('#product_size_british_size').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "british_size") {
      $('#size-uk-param').removeClass('hidden');
    }
  });

  $('#product_size_asian_size').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "asian_size") {
      $('#size-az-param').removeClass('hidden');
    }
  });
});
