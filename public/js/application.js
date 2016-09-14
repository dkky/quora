
// $(document).ready(function() {
// 	$('#signup-button').click(function()
// 		${'#signup-div'}.show()
// 	});
// });

// function signupbutton() {
// 	    var x = document.getElementById('signup-div');
// 	    if (x.style.display === 'none') {
// 	        x.style.display = 'block';
// 	    } else {
// 	        x.style.display = 'none';
// 	    }
// }



$(document).ready(function(){
	$('#navbar-question').submit(function(e){
		debugger
		e.preventDefault();
		$.ajax({
			url: '/user/question',
			method: 'POST',
			data: $(this).serialize(),
			dataType: 'html',
			success: function(data){
				$("#question-form").prepend(data);
			},
		})
	});

	$('.question-vote').on('submit', 'form',function(e){
		debugger
		var url = $(e.target).attr('action');
		e.preventDefault();
		$.ajax({
			url: url,
			method: 'POST',
			data: $(this).serialize(),
			dataType: 'html',
			success: function(data){
				$(e.target).parent().html(data)
			},
		})
		// flow: submit form > send ajax request > server change data in database accordingly > prepare html > send html over to javascript/jquery > jquery adds the html
	});
});

				// ("<p>" + data.title  + "</p>");