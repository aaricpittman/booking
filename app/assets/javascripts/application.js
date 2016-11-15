// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

if (typeof booking === 'undefined') {
  booking = { a: 'a' };
}

(function($) {
  "use strict";

  booking = (function() {
    var fetchRoomTypes = function(hotelId, callback) {
      $.ajax({
        url: '/api/v1/hotels/'+hotelId+'/rooms/types_count',
        success: function(data, status, request){
          callback(data.types);
        },
        error: function(request, status, error) {
          console.log('ERROR:', error);
        }
      });
    };

    var processRoomTypes = function(types) {
      var $roomTypeSelect = $('#room_type_id');

      $roomTypeSelect.find('option').remove();
      $roomTypeSelect.append('<option value></option>');

      $.each(types, function(index, type) {
        var value = type.id;
        var text = type.name+' ('+type.count+')';

        $roomTypeSelect.append('<option value="'+value+'">'+text+'</option>');
      });

      $('#room-field').show();
    };

    var checkForExistingHotelSelection = function() {
      var hotelId = $('#hotel_id').val();

      if(hotelId !== '' && hotelId > 0) {
        fetchRoomTypes(hotelId, processRoomTypes);
      }
    };

    var setupBookingForm = function() {
      checkForExistingHotelSelection();

      $('#hotel_id').change(function() {
        var hotelId = $(this).val();

        if (hotelId === '') {
          $('#room-field').hide();
          return;
        }

        fetchRoomTypes(hotelId, processRoomTypes);
      });
    };

    return {
      setupBookingForm: setupBookingForm
    };
  })();
})(jQuery);
