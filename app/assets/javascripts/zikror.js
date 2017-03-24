var media;
var imgs = {
	play: '/assets/play-button.png',
	pause: '/assets/pause-button.png',
	like: '/assets/like.png',
	liked: '/assets/like_red.png'
};
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

	// player
	$('audio').each(function(){
		$(this).attr('src', $('.th-music img').first().data('music'));
	});

	var index = 0;
	$(document).on('click','.play-music', function(){
		index = $(this).data('index');
		$('td a').css('color', '#fff');
		$('.th-music img').attr('src', imgs.play);

		$(this).attr('src', imgs.pause);
		$(this).parent().parent().addClass('active-music').siblings().removeClass('active-music');
		$(this).removeClass('play-music').addClass('pause-music');
		var audio_src = $(this).attr('data-music');
		$('audio').each(function(){
			if($(this).attr('src') !== audio_src){
				$(this).attr('src', audio_src);
			}
			this.player.getCurrentTime();
			this.player.play();
		});
	});

	//pause button
	$(document).on('click','.pause-music', function(){
		$('.th-music img').attr('src', imgs.play);
		$(this).attr('src', imgs.play);
		$(this).removeClass('pause-music').addClass('play-music');
		var audio_src = $(this).attr('data-music');
		$('audio').each(function(){
			this.player.pause();
		});
	});

	//play option 2
	$(document).on('click', '.mejs__play button', function(){
		$('.th-music img').eq(index).attr('src', imgs.pause);
		$('.th-music img').eq(index).parent().parent().addClass('active-music').siblings().removeClass('active-music');
	});

	$(document).on('click', '.mejs__pause button', function(){
		$('.th-music img').eq(index).attr('src', imgs.play);
	});

	$('#mejs').on('ended', function(){
		if($('#continue').is(':checked')){
			$('.th-music img').eq(index).attr('src', imgs.play);
			index = (index + 1) % $('.th-music img').length;
			$('.th-music img').eq(index).attr('src', imgs.pause);
			var url = $('.th-music img').eq(index).data('music');
			$('audio').each(function(){
				if($(this).attr('src') !== url){
					$(this).attr('src', url);
				}
			    this.player.play();
			});
			$('.th-music img').eq(index).parent().parent().addClass('active-music').siblings().removeClass('active-music');
		}
		else{
			$('.th-music img').eq(index).attr('src', imgs.play);
		}
	});

	// navigation
	if(localStorage.getItem('hide') === 'true'){
		menuToggle();
	}

	$('.menu-profil').click(function(){
		if(localStorage.getItem('hide') == 'true')
			localStorage.setItem('hide', false);
		else
			localStorage.setItem('hide', true);
		menuToggle();
	});

	$('.content-page').perfectScrollbar();
	$('.profil-side').perfectScrollbar();
	$('.sidebar').perfectScrollbar();
	$('.bloc-bottom').perfectScrollbar();

	if(localStorage.getItem('rightSidebarView') !== 'parcourir'){
		$(".right-tabs a[href='#right-profil']").tab('show');
		$('.bloc-bottom').scrollTop(0);
		$('.bloc-bottom').perfectScrollbar('update');
	} else {
		$(".right-tabs a[href='#right-parcourir']").tab('show');
	}

	$(document).on('click', "a[href='#right-profil']", function(){
		localStorage.setItem('rightSidebarView', 'mon-profil');
	});

	$(document).on('click', "a[href='#right-parcourir']", function(){
		localStorage.setItem('rightSidebarView', 'parcourir');
		$('.bloc-bottom').scrollTop(0);
		$('.bloc-bottom').perfectScrollbar('update');
	});

	$('.bloc-pop span').click(function(){
		$(this).css('outline','none');
		$('.popover').toggleClass('active-pop');
	});

	// Add song to playlist
	var song_id;

	$("a[data-song]").click(function(){
		song_id = $(this).data('song');
		$('#add_song input[type=submit]').prop('disabled', false)
	});

	$('#add_song').submit(function(e){
	    e.preventDefault();
	    $.post('/playlists/add_song',
	    {
	      song_id: song_id,
	      playlist_id: $('#playlist_id').val()
	    },
	    function(data){
			$('.modal-backdrop.fade.in').hide();
	        $('#exampleModalLong').hide();
	        $('body').prepend($(
				`<div class="alert alert-info alert-dismissable">
					<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					<strong>${data}</strong>
				</div>`));
	    });
	 });

	// Favorites
	$('a.favorite').click(function(e){
	    e.preventDefault();
	    var song_id = $(this).data('song');
	    var that = this;
	    $.get(`/songs/favorite/${song_id}`, function(data){
			var img = $(that).children().first();
			if(img.attr('src').indexOf('red') !== -1)
				img.attr('src', imgs.like);
			else
				img.attr('src', imgs.liked);
		});
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

function menuToggle(){
	$('.profil-side').toggle();
	$('.content-page').toggleClass('clicked');
	$('.nav-profil').toggleClass('clicked');
	$('.close-img').toggleClass('clicked');
	$('.show-img').toggleClass('clicked');
}
