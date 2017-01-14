/**
 * Created by loreinne on 12/20/16.
 */
$(document).ready(function() {
    $("#ven").click(function () {
        $("#ven2").show();
        $("#new-content").hide();
        $("#cat2").hide();

    });
    $("#cat").click(function () {
        $("#ven2").hide();
        $("#new-content").hide();
        $("#cat2").show();

    });
});
