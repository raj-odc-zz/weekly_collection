/**
 * Created by Selvaraj on 2/7/15.
 */
$(function() {
    $('.datepicker').datepicker({
        format: 'dd-mm-yyyy',
        orientation: "top right",
        todayHighlight: false,
        autoclose: true});
});

$(document).ready(function() {
    jQuery(".best_in_place").best_in_place();
});
