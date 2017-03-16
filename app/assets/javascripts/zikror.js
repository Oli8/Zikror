var media;
$(document).ready(function() {
	//option view password
	$('.view').click(function(e){
		viewPassword('text');
		$(this).css('display','none');
		$('.notview').css('display','block');
	});

	$('.notview').click(function(e){
		viewPassword('password');
		$(this).css('display','none');
		$('.view').css('display','block');
	});

	//upload file custom
	$(".upload").change(function(){
	 	var fullPath = $(this).val();
		if (fullPath) {
			var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
			var filename = fullPath.substring(startIndex);
			if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
			  filename = filename.substring(1);
			}
			$("#value-file").val(filename);
		}
	});

	//mediaelementjs
	$('audio').mediaelementplayer({
    success: function (mediaElement, domObject) {
      media = mediaElement;  
    }
  });

});

//function view passord show in top of this code
function viewPassword(value){
	$('.password').prop('type', value)
}

function mejsPlayNext(currentPlayer) {
    if ($('.active-music .play-music').length > 0){ // get the .current song
        var current_item = $('.active-music .play-music:first'); // :first is added if we have few .current classes
        var audio_src = $(current_item).next().attr('data-music');
        $(current_item).parent().parent().next().addClass('active-music').siblings().removeClass('active-music');
        console.log('if '+audio_src);
    }else{ // if there is no .current class
        var current_item = $('th .play-music:first'); // get :first if we don't have .current class
        var audio_src = $(current_item).next().attr('data-music');
        $(current_item).parent().parent().next().addClass('active-music').siblings().removeClass('active-music');
        console.log('elseif '+audio_src);
    }
}

/*$('.th-music img').click(function(player){
	var audio_src = $(this).attr('data-music');
	alert(audio_src);
	alert($(this).attr('class'));
	if($(this).attr('class') == 'pause-music'){
		$('audio').each(function(){
			this.player.pause();
		});
	}
	if ($(this).attr('class') == 'play-music'){
		$('audio').each(function(){
			this.player.getCurrentTime();
			$(this).attr('src', audio_src);
			this.player.play();
		});
	}
});*/