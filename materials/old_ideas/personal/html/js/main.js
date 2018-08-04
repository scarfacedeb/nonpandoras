$(document).ready(function(){
	initCat();
});

function initCat(){
	var $container = $('.subgroup');

	$container.imagesLoaded( function(){
	  $container.masonry({
		itemSelector : '.box'
	  });
	});
}