$
  $( document ).ready(function() {
    $('#product_industry').on('change', function() {
      var industry = $(this).val();
      if (industry === "fashion") {
        $('#size-param').removeClass('hidden');
      }
    });
  });
