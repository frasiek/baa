/**
 * Created by frasiek on 2015-01-31.
 */
function categorizerCls(){
    this.init();
}

categorizerCls.prototype.init = function(){
    var t = this;
    $(".addCategorie").click(function(e){
        e.preventDefault();
        t.addCategorie();
    });
    $(".add-category-submit").click(function(e){
        e.preventDefault();
        t.submitForm();
    });
}

categorizerCls.prototype.addCategorie = function(){
    $("#key-word").val(this.getSelectionText());
    $("#addcategoriemodal").modal("show");
}

categorizerCls.prototype.getSelectionText = function() {
    var text = "";
    if (window.getSelection) {
        text = window.getSelection().toString();
    } else if (document.selection && document.selection.type != "Control") {
        text = document.selection.createRange().text;
    }
    return text;
}
categorizerCls.prototype.submitForm = function(){
    var params = $("#add-category-form").serialize();
    $.post("categorize/addCategorie.json",params,function(response){
         if(response.success == "success"){
             $("#addcategoriemodal").modal('hide');
             $("#add-category-form input").val("");
             location.reload()
         } else {
             alert(response.message)
         }
    },'json');
}

$(document).ready(function(){
    var categorier = new categorizerCls();
});