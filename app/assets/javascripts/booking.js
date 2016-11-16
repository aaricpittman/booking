if (typeof booking === 'undefined') {
  booking = {};
}

(function($) {
  "use strict";

  booking = (function() {
    var stripePublishableKey = '';
    var stripe = null;
    var roomTypes = [];
    var hotelSelectId = '#reserve_a_room_hotel_id';
    var checkInId = '#reserve_a_room_check_in';
    var checkOutId = '#reserve_a_room_check_out';
    var roomTypeSelectId = '#reserve_a_room_room_type_id';

    var fetchRoomTypes = function(hotelId, callback) {
      $.ajax({
        url: '/api/v1/hotels/'+hotelId+'/rooms/available_types',
        success: function(data, status, request){
          callback($.map(data.types, function(type) {
            return extendRoomType(type);
          }));
        },
        error: function(request, status, error) {
          console.log('ERROR:', error);
        }
      });
    };

    var processRoomTypes = function(types) {
      var $roomTypeSelect = $(roomTypeSelectId);
      roomTypes = types;

      $roomTypeSelect.find('option').remove();
      $roomTypeSelect.append('<option value></option>');

      $.each(types, function(index, type) {
        $roomTypeSelect.append('<option value="'+type.id+'">'+type.toLabel()+'</option>');
      });

      $('#room-field').show();
    };

    var extendRoomType = function(type) {
      return $.extend(
        {},
        type,
        {
          toDollars: function() {
            return (this.rate_cents/100).toFixed(2);
          },
          toLabel: function() {
            return this.name+' ($'+this.toDollars()+' per night)';
          }
        }
      )
    }

    var findSelectedRoomType = function() {
      var roomTypeId = $(roomTypeSelectId).val();

      return $.grep(roomTypes, function(roomType) {
        return (roomType.id == roomTypeId);
      })[0];
    };

    var checkForExistingHotelSelection = function() {
      var hotelId = $(hotelSelectId).val();

      if(hotelId !== '' && hotelId > 0) {
        fetchRoomTypes(hotelId, processRoomTypes);
      }
    };

    var calculateTotal = function() {
      var roomType = findSelectedRoomType();
      var numberOfNights = booking.utility.dayDiff(
        $(checkInId).val(),
        $(checkOutId).val()
      );

      return (roomType.rate_cents * numberOfNights);
    };

    var getStripeOptions = function() {
      var hotelName = $(hotelSelectId).find('option:selected').text();
      var roomType = findSelectedRoomType();
      var checkIn = $(checkInId).val();
      var checkOut = $(checkOutId).val();
      var total = calculateTotal();

      return {
        name: roomType.name+' at '+hotelName,
        description: checkIn+' - '+checkOut,
        amount: total
      }
    }

    var openStripeCheckout = function() {
      stripe = StripeCheckout.configure({
        key: stripePublishableKey,
        locale: 'auto',
        token: function(token) {
          $('input#reserve_a_room_stripe_token').val(token.id);
          $('form').submit();
        }
      });

      stripe.open(getStripeOptions());
    };

    var validateForm = function() {
      var errorMsgs = [];
      var valid = true;

      if($(checkInId).val() === '') {
        errorMsgs.push("Check in can't be blank");
        valid = false;
      }

      if($(checkOutId).val() === '') {
        errorMsgs.push("Check out can't be blank");
        valid = false;
      }

      if($(hotelSelectId).val() === '') {
        errorMsgs.push("You must select a hotel.");
        valid = false;
      }

      if($(hotelSelectId).val() !== '' && $(roomTypeSelectId).val() === '') {
        errorMsgs.push("You must select a room type.");
        valid = false;
      }

      if(!valid) {
        renderErrorMessages(errorMsgs);
      }

      return valid;
    };

    var renderErrorMessages = function(messages) {
      var source   = $("#error-template").html();
      var template = Handlebars.compile(source);
      var context  = {
        count: messages.length,
        messages: messages
      };

      $('#new_reserve_a_room').prepend(template(context));
    };

    var setupBookingForm = function(stripeKey) {
      checkForExistingHotelSelection();

      $(hotelSelectId).change(function() {
        var hotelId = $(this).val();

        if (hotelId === '') {
          $('#room-field').hide();
          return;
        }

        fetchRoomTypes(hotelId, processRoomTypes);
      });

      $('#create-reservation-btn').click(function(evt) {
        evt.preventDefault();

        if(validateForm()) {
          openStripeCheckout();
        }
      });

      stripePublishableKey = stripeKey;
    };

    return {
      setupBookingForm: setupBookingForm
    };
  })();
})(jQuery);