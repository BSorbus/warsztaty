$(document).ready(function() {
  function toggleChevron(e) {
      $(e.target)
          .parent()
          .find("i.indicator")
          .toggleClass('glyphicon-chevron-down glyphicon-chevron-right');
  }
  $('#myaccordion').on('hidden.bs.collapse', toggleChevron);
  $('#myaccordion').on('shown.bs.collapse', toggleChevron);

});
