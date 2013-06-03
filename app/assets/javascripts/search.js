$.ajaxSetup ({
    // Disable caching of AJAX responses
    cache: false
});
$(function() {

	var searching = false, query;

	$('#search').keyup(function(){
		query = $('#search').val();
		searching = true;
		$('#content').slideUp(400, function(){
			$(this).children().remove();
			$(this).wrap('<div class="fake"></div>');
			$(this).remove();
			$('.fake').load(window.location.pathname+'/search #content', {search: query}, showContent());
		});
	});

	var showContent = function(){
		$('.fake').hide();
		$('.fake').slideDown(300);
	}

	// $('#search').bind({
	// 	'input' : function () {
	// 		searching = true;
	// 		query = $('#search').val();

	// 			$('#content *').fadeOut(400, function(){
	// 				$.ajax({
	// 					url: window.location.pathname+'/search',
	// 					data: { search: query },
	// 					success: function(data){
	// 						var page = $.parseHTML(data);
	// 						var content = $(page).children('#content').html();
	// 						console.log(content);
	// 						$('#content').html(content);
	// 					}
	// 				})
	// 			});
	// 	}
	// });

});