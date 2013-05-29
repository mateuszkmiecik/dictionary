$(function(){

	// jQuery magic

	$('#close_notice').click(function(){
		$(this).parent('#flash_notice').fadeOut(400, function(){
			$(this).remove();
		});
	});

	
});