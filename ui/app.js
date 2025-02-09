$(document).ready(function(){
    
    $(".bodycam").hide();
    $(".odz").hide();
    window.addEventListener("message", function(event){
        if(event.data.open == true)
        {
            $(".odz").fadeIn();
            $(".bodycam").fadeIn();
            document.getElementById("data").innerHTML = event.data.date;
            document.getElementById("stopien").innerHTML = event.data.ranga;
            document.getElementById("dane").innerHTML = event.data.daneosoby;
            //document.getElementById("brkblnt").innerHTML = event.data.para;
        }
        else if(event.data.open == false) 
        {
            $(".bodycam").hide();
			$(".odz").hide();
        }
    })
});