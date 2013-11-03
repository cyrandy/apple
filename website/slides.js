		$(function(){
		  $("#slides").slidesjs({
		    width: 1280,
		    height: 700,
		    play: {
		  active: true,
		    // [boolean] Generate the play and stop buttons.
		    // You cannot use your own buttons. Sorry.
		  effect: "slide",
		    // [string] Can be either "slide" or "fade".
		  interval: 5000,
		    // [number] Time spent on each slide in milliseconds.
		  auto: true,
		    // [boolean] Start playing the slideshow on load.
		  swap: false,
		    // [boolean] show/hide stop and play buttons
		  pauseOnHover: true,
		    // [boolean] pause a playing slideshow on hover
		  restartDelay: 5000
		    // [number] restart delay on inactive slideshow
		}
		  });
		});
