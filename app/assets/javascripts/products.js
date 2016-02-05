$( document ).ready(function() {
  $('#product_industry').on('change', function() {
    var industry = $(this).val();
    if (industry === "Fashion") {
      $('#fashion-param').removeClass('hidden');
    }
  });

  $('#product_size_ru').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "ru") {
      $('#size-ru-param').removeClass('hidden');
    }
  });

  $('#product_size_eu').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "eu") {
      $('#size-eu-param').removeClass('hidden');
    }
  });

  $('#product_size_us').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "us") {
      $('#size-us-param').removeClass('hidden');
    }
  });

  $('#product_size_uk').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "uk") {
      $('#size-uk-param').removeClass('hidden');
    }
  });

  $('#product_size_az').on('change', function() {
    var size = $(this).val();
    $(".country-sizes").addClass('hidden');
    if (size === "az") {
      $('#size-az-param').removeClass('hidden');
    }
  });
});
