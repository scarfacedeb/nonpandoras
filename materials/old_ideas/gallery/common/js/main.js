var accord, content;

$.extend({}, env, {
	init: function(){
		accord = $("#accord");
		content = $("#content");

		accord.on("click", ".sliceJS", function(){
			openslice(this);
		});
	},
	openslice: function(slice){
		var $slice = $(slice);

		accord.find(".selected").removeClass("selected");
		
		var otherslices = accord.find(".sliceJS").not($slice);
		otherslices.addClass("folded", env.speed);

		content.addClass("unfolded");
		
		$slice.addClass('selected');
	}
});


var env2 = {
	self: function(){
		console.log(this);
	}
}

var env3Constructor = function(){
	console.log(this);
	return this;
}

var env3 = new env3Constructor();