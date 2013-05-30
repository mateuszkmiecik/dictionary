$(function(){

	// jQuery magic

	var noticeClose = function(){
		$('#flash_notice').slideUp(400, function(){
			$(this).remove();
		});
	}

	$('#close_notice').click(function(e){
		e.preventDefault();
		noticeClose();
	});

	if($('#flash_notice').length > 0){
		setTimeout(noticeClose, 3000);
	}

	
});