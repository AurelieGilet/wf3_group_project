// $(document).ready(function() {

// 	var auto_refresh = setInterval( function () {
// 		$.ajax({ 
// 		  type: "POST",
// 		  url: "URL_TO_PHP_FILE",  
// 		  data: "refreshStatus",
// 		  success: function(status){          
// 			$('#Status').text(status); 
// 		  },
// 		});
// 	}, 1000); 
// }

$(document).ready(function() {
	// auto refresh page after 1 second
	setInterval('refreshPage()', 2000);

	function refreshPage() { 
		location.reload(); 
	}
});


