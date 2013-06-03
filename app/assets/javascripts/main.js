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
		setTimeout(noticeClose, 5000);
	}

	$('#menuicon').click(function(e){ e.preventDefault(); });


	$('.field_with_errors input').focus(function(){
		if( $(this).parent().is('div.field_with_errors')){
			$(this).unwrap();
			$(this).focus();
		}
	});

	
});