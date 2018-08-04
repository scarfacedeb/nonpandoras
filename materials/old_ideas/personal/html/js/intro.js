function parallax(){
	$('.parallax-layer').parallax({
		mouseport: $("#parallax")
	},{ //-6
		xparallax: '200px',
		yparallax: '50px',
		yorigin: 0,
		xorigin: 0
	},{ //-5
		xparallax: '150px',
		yparallax: '190px',
		yorigin: 0,
		xorigin: 0
	},{ //-4
		//xparallax: '50px',
		//xorigin: 1.15,
		//yparallax: false
	},{ //-3
		//xparallax: '40px',
		//xorigin: 1,
		//yparallax: '10px'
	});
}
function initCat(){
	var $container = $('.subgroup');

	$container.imagesLoaded( function(){
	  $container.masonry({
		itemSelector : '.box',
		gutterWidth: 15
	  });
	});
}


$(document).ready(function(){
	parallax();
	//initCat();
});