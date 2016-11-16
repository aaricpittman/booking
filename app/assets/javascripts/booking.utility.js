if (typeof booking === 'undefined') {
  booking = {};
}

(function($, app) {
  "use strict";

  app.utility = (function() {
    var parseDate = function(str) {
      var mdy = str.split('-');
      return new Date(mdy[0], mdy[1], mdy[2]);
    }

    var dayDiff = function(first, second) {
      first = parseDate(first);
      second = parseDate(second);

      return Math.round((second-first)/(1000*60*60*24));
    }

    return {
      parseDate: parseDate,
      dayDiff: dayDiff
    }
  })();

})(jQuery, booking);
