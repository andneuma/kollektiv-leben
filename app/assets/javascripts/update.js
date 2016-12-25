jQuery(function() {

  jQuery(document).ajaxSuccess(function(event, xhr, status){
    if (status.type == 'POST') {
      jQuery('.modal').modal('hide');
    };
  });

  jQuery(document).ajaxError(function(event, xhr, status, error){
    var errors = xhr.responseText;
    jQuery('.modal-body > .alert-danger').remove();
    jQuery('.modal-body').append("<div class='alert alert-danger'>" + errors + "</div>");
  });

});
