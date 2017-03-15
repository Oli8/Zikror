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

	// //set scrollbar custom for specific content
	// $('.content-page').perfectScrollbar(); 
	// $('.profil-side').perfectScrollbar(); 
	// $('.sidebar').perfectScrollbar();
	
	//sidemenu right
	// if(localStorage.getItem('hide') === 'true'){
 //    	menuToggle();
	// }

	// $('.menu-profil').click(function(){
 //    	localStorage.setItem('hide', true);
 //    	menuToggle();
	// });

	//navigation horizontal
	// var contentTable = $('.active-list').attr('data-content');

	// $('.nav-profil li').click(function(){
	// 	$('.nav-profil li').removeClass('active-list');
	// 	var contentTable = $(this).attr('data-content');
	// 	$('.table').hide();

	// 	$(this).addClass('active-list');
	// 	$('.'+contentTable).css('display','inline-table');
	// });

	//mediaelementjs
	$('audio').mediaelementplayer({
    success: function (mediaElement, domObject) {
      media = mediaElement;  
    }
  });

 //  //play button
	// $(document).on('click','.play-music', function(){
 //  	$('.th-music img').attr('src','img/play-button.png');

	// 	$(this).attr('src','img/pause-button.png');
	// 	$(this).parent().parent().addClass('active-music').siblings().removeClass('active-music');
	// 	$(this).removeClass('play-music').addClass('pause-music');
	// 	var audio_src = $(this).attr('data-music');
	// 	$('audio').each(function(){ 
	// 		if($(this).attr('src') !== audio_src){
	// 			$(this).attr('src', audio_src);
	// 		}	
	// 		this.player.getCurrentTime();
 //     	this.player.play();
 //  	});
	// });

	// //play option 2
	// $(document).on('click', '.mejs__play button', function(){
	// 	$('.active-music .pause-music').attr('src','img/pause-button.png');
	// });
	
	// //pause button
	// $(document).on('click','.pause-music', function(){
 //  	$('.th-music img').attr('src','img/play-button.png');
  	
	// 	$(this).attr('src','img/play-button.png');
	// 	$(this).removeClass('pause-music').addClass('play-music');
	// 	var audio_src = $(this).attr('data-music');
	// 	$('audio').each(function(){ 
 //      this.player.pause();
 //  	});
	// });

	//pause option 2



});

//function view passord show in top of this code
function viewPassword(value){
	$('.password').prop('type', value)
}

//function for sidemenu profil
// function menuToggle(){
// 	$('.profil-side').toggle();
// 	$('.content-page').toggleClass('clicked');
// 	$('.nav-profil').toggleClass('clicked');
// 	$('.close-img').toggleClass('clicked');
// 	$('.show-img').toggleClass('clicked');
// }

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