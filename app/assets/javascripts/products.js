$( document ).on("last-element-rendered", function() {
  $('#product_industry').on('change', function() {
    var industry = $(this).val();
    if (industry === "fashion") {
      $(".country-sizes, .group-sizes, .child_age_sizes").addClass('hidden');
      $('#fashion-param, #gender').removeClass('hidden');
    } else if (industry === "cosmetic") {
      $(".country-sizes, .group-sizes, .child_age_sizes, .product_type").addClass('hidden');
      $('#cosmetic-param, #gender, #periodic, #hypoallergenic').removeClass('hidden');
    } else if (industry === "child") {
      $(".country-sizes, .group-sizes, .country-periodic").addClass('hidden');
      $('#gender, #child_age_sizes').removeClass('hidden');
    }
  });

  // This is for product size
  $('[name="product[size]"]').on('change', function() {
    $(".group-sizes").addClass('hidden');
    $('#pro-' + $(this).attr('id')).removeClass('hidden');
  });

  // This is for product child size for age
  $('#product_child_ages_0').on('change', function() {
    $(".child_age_sizes").addClass('hidden');
    $('#child-less, #child-tyes').removeClass('hidden');
  });

  // when click Age more than 2 remove ages sizes form age less then 2
  $('#product_child_ages_1').on('change', function() {
    $("#child-less, .type-sizes, .group-sizes, .country-sizes-types, #size-types").addClass('hidden');
    $('#child-tyes').removeClass('hidden');
  });

  // Show child/adult size & Periodic when type have sizes/Periodic
  $('[name="product[product_type]"]').on('change', function() {
    var value = $(this).val();
    if (['18', '19', '9', '0', '1', '2', '3', '4', '5'].indexOf(value) > -1) {
      $('#hypoallergenic, #periodic').addClass('hidden');
      $('#size-types').removeClass('hidden');
    } else if (['13'].indexOf(value) > -1) {
      $('#periodic').removeClass('hidden');
      $('.group-sizes, .country-sizes-types, #hypoallergenic').addClass('hidden');
    } else if (['12'].indexOf(value) > -1) {
      $('.group-sizes, .country-sizes-types').addClass('hidden');
      $('#hypoallergenic, #periodic').removeClass('hidden');
    } else if (value) {
      $(".child_group_sizes, .group-sizes, .country-sizes-types, .country-periodic, .country-hypoallergenic").addClass('hidden');
    }
  });
});


// Popup cart product

$(document).ready(function($){
  //open popup
  $('.itemAddToCard').on('click', function(event){
    event.preventDefault();
    $('.cd-popup').addClass('is-visible');
  });

  //close popup
  $('.cd-popup').on('click', function(event){
    if( $(event.target).is('.cd-popup-close') || $(event.target).is('.cd-popup') ) {
      event.preventDefault();
      $(this).removeClass('is-visible');
    }
  });
  //close popup when clicking the esc keyboard button
  $(document).keyup(function(event){
    if(event.which=='27'){
      $('.cd-popup').removeClass('is-visible');
    }
  });
});
