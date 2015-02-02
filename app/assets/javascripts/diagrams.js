/**
 * Created by frasiek on 2015-02-02.
 */
//= require excanvas.min
//= require jquery.jqplot.min

$(document).ready(function(){
    $("#filters").submit(function(e){
        e.preventDefault();
        var type = $("[data-type]").attr("data-type");
        $.post("/report/data.json",{type:type, filters: $(this).serialize()},function(response){
            console.log(response)
        },'json');
    });
});