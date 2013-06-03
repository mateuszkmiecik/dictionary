$.ajaxSetup ({
    // Disable caching of AJAX responses
    cache: false
});
$(function() {

	var searching = false, query, height;
	$('#content').wrap('<div class="fake"></div>');
	height = $('.fake').height();
	console.log(height);

	$('#search').bind('input', function(){
		query = $('#search').val();
		searching = true;
		if($('.loader').length == 0){
			$('<p class="loader"><i class="icon-spinner icon-spin icon-large""></i></p>').prependTo('.fake');
		}
		$('#content').fadeOut(200, function(){
			$('.fake').height(height);
			$(this).children().remove();
			$(this).remove();
			$('.fake').load(
					window.location.pathname+'/search #content',
					{search: query},
					function(){
						height = $('#content').height();
						$('#content').hide();
						$('.fake').animate({
							'height': height
						}, 300, function () {
							$('#content').fadeIn(300);
						});
					}
				);
		});
	});

});