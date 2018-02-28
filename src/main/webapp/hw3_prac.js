var slider;
var sideslider;
var signbut;
var box;
var numposts;
var box2;
var thebod;
var meme;
var music;
var cycle;
var cycle2;
var vid;
var vid2;
var fader;
var opac = 1.0;
var opac2 = 1.0;
var height;
var vol = 0.4;
var oldman1;
var oldman2;
var oldman3;
var oldman4;
var oldman5;
var oldman6;
var quote;
var itval;
var flag = true;
var logflag = false;

var backgrounds = ['one.jpg', 'two.jpg', 'three.png', 'four.jpg', 'five.jpg', 'six.jpg', 'seven.jpg'];
var fonts = ["'Monoton', cursive", "'Press Start 2P', cursive", "'Freckle Face', cursive", "'Fredericka the Great', cursive", "'Bigelow Rules', cursive", "'Fontdiner Swanky', cursive", "'Butcherman', cursive"];
var hold = 0;
var hold1 = 0;

function cycleground(){
	document.body.style.backgroundImage = "url(\""+backgrounds[hold]+"\")";
	hold = (hold + 1) % 7;
}

function cyclefonts(){
	box2.style.fontFamily = fonts[hold1];
	box2.style.fontSize = Math.floor(Math.random() * (50 - 5 + 1)) + 5+"px";
	hold1 = (hold1 + 1) % 7;
}

function onSuccess(googleUser) {
    console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
}

function onFailure(error) {
    console.log(error);
}

function renderButton() {
    gapi.signin2.render('my-signin2', {
      'scope': 'profile email',
      'width': 240,
      'height': 50,
      'longtitle': true,
      'theme': 'dark',
      'onsuccess': onSuccess,
      'onfailure': onFailure
    });
}

/*
function preload(){
	var img1 = new Image();
	var img2 = new Image();
	var img3 = new Image();
	var img4 = new Image();
	var img5 = new Image();
	var img6 = new Image();
	var img7 = new Image();

	img1.src = backgrounds[0];
	img2.src = backgrounds[1];
	img3.src = backgrounds[2];
	img4.src = backgrounds[3];
	img5.src = backgrounds[4];
	img6.src = backgrounds[5];
	img7.src = backgrounds[6];

	myImages[0] = img1;
	myImages[1] = img2;
	myImages[2] = img3;
	myImages[3] = img4;
	myImages[4] = img5;
	myImages[5] = img6;
	myImages[6] = img7;
}
*/

window.addEventListener('DOMContentLoaded', function(){
	slider = document.getElementById("myRange");
	sideslider = document.getElementById("myRange2");
	downslider = document.getElementById("myRange3");
	finalslider = document.getElementById("myRange4");
	vid = document.getElementById("thevid");
	vid2 = document.getElementById("thevid2");
	box = document.getElementById("thebox");
	box2 = document.getElementById("thebox2");
	thebod = document.getElementById("ohyeah");
	meme = document.getElementById("thisisdumb");
	music = new Audio('Cinder1.mp3');
	oldman1 = new Audio('oldman1.mp3');
	oldman2 = new Audio('oldman2.mp3');
	oldman3 = new Audio('oldman3.mp3');
	oldman4 = new Audio('oldman4.mp3');
	oldman5 = new Audio('oldman5.mp3');
	oldman6 = new Audio('oldman6.mp3');
	quote = new Audio('quote.mp3');
	numposts = parseInt(document.getElementById("postnum").value);
	if(document.getElementById("loginval").value == "true"){
		signbut = document.getElementById("signimg");
	} 
	
	height = 2.0 * thebod.scrollHeight; 
	thebod.style.backgroundSize = "200% "+height+"px, cover";
	
	var slideRect = sideslider.getBoundingClientRect();
	console.log(slideRect.top, slideRect.right, slideRect.bottom, slideRect.left);
	
/*	sideslider.style.width = (0.9  * document.documentElement.scrollHeight) + 'px';
	var slideRect = sideslider.getBoundingClientRect();
	console.log(slideRect.top, slideRect.right, slideRect.bottom, slideRect.left);
    sideslider.style.marginLeft = (document.documentElement.clientWidth - slideRect.bottom) + 'px';
    sideslider.style.marginTop = (document.documentElement.scrollHeight * 0.45) + 'px';*/

	sideslider.max = (numposts - 1) * 20;
	sideslider.value = (numposts - 1) * 20;
	
	vid2.style.opacity = 0.0;

	finalslider.style.marginLeft = "45%";
	finalslider.style.marginTop = "5%";

	document.body.scrollTop = document.documentElement.scrollTop = 0;

	oldman1.play();

	console.log(numposts);

	music.addEventListener('play', function() {
		var player = setTimeout(function() {
			clearInterval(cycle);
			clearInterval(cycle2);
			vid.volume = 0.4;
			vid.play();
			oldman6.play();
			vid.style.display = "block";
			box.style.display = "none";
			box2.style.display = "none";
		}, 26306);
		var player1 = setTimeout(function() {	
			quote.play(); 
		}, 54611);
	}, false);

  vid.addEventListener('play', function() {
	  setTimeout(function() {
			thebod.style.backgroundColor = "#000000";
			thebod.style.backgroundImage = "none";
			vid2.style.display = "block";
			vid2.play();
      fader = setInterval(function() {
        if(opac <= 0.0){
          clearInterval(fader);
          vid.pause();
          vid.style.display = "none";
          vid.volume = 0;
        } else {
          opac = opac - 0.01;
          vid.style.opacity = opac;
          vid2.style.opacity = 1.0 - opac;
          vol = vol - 0.004;
          vid.volume = vol; 
        }
      }, 80);

  	}, 16000);

  }, false);
  	
  vid2.addEventListener('play', function(){
	  setTimeout(function(){
		  vid2.pause();
	      meme.style.display = "block";
	      meme.style.visibility = "visible";
	      document.getElementById("restart").style.visibility = "visible";
	      fader2 = setInterval(function() {
	    	  	if(opac2 <= 0.0){
					clearInterval(fader2); 
					vid2.style.zIndex = "-100";
					vid2.style.display = "none";
					vid2.style.visibility = "hidden";
				} else {
					opac2 = opac2 - 0.01;
					vid2.style.opacity = opac2; 
				}
	      }, 80);	
	  }, 57514);
  }, false);

  oldman5.addEventListener('ended', function() {
    music.volume = 1.0;
  }, false);

	slider.oninput = function() {
    if(this.value > 84){
      this.style.display = "none";
      sideslider.style.display = "block";
      sideslider.style.width = (0.9  * document.documentElement.scrollHeight) + 'px';
  	  var slideRect = sideslider.getBoundingClientRect();
  	  console.log(slideRect.top, slideRect.right, slideRect.bottom, slideRect.left);
      //sideslider.style.marginLeft = (slideRect.left + (document.documentElement.scrollWidth - slideRect.left)) + 'px';
  	  var slideRect = sideslider.getBoundingClientRect();
  	  sideslider.style.marginLeft = (document.documentElement.scrollWidth * 0.95 - slideRect.left)+"px";
  	  //sideslider.style.marginTop = (document.documentElement.scrollHeight * 0.45) + 'px';
  	  //sideslider.style.marginTop = "";
  	  sideslider.style.marginTop = -(slideRect.top - 100)+"px";
  	  
  	  if(document.getElementById("loginval").value == "true"){
  		  signbut.src = "btn_google_signin_dark_pressed_web.png";
	  } 
  	  
      document.getElementById("headpic").style.visibility = "visible";
      oldman1.pause();
      oldman2.play();
    } else if(slider.value >= 0){
      if(!box.classList.contains('transbox')){
			box.classList.add('transbox');
			box2.classList.add('transbox');
			height = 2.0 * thebod.scrollHeight; 
			thebod.style.backgroundSize = "200% "+height+"px, cover";
      }
      		box.style.width = this.value+'%';
			box2.style.width = this.value+'%';
		} else {
      box.classList.remove('transbox');
			box2.classList.remove('transbox');
    }
	}

/*
	sideslider.oninput = function() {   
    if(this.value > -10){
      thebod.style.backgroundSize = "100% "+this.value+"%, cover";
    } else if(this.value == 50) {
      thebod.style.backgroundSize = "100% "+this.value+"%, cover";
		} else {
      thebod.style.backgroundSize = "0% 0%, cover"; 
			thebod.style.backgroundRepeat = "repeat-y";
      this.style.display = "none";
      downslider.style.display = "block";
      oldman2.pause();
      oldman3.play();
    }
	} 
*/
	sideslider.oninput = function() {   
		if(this.value > -1){
			for (i = 0; i < numposts; i++){
				if(i < numposts - 1 - (this.value / 20)){
					document.getElementById("title"+i).classList.add("title");
					document.getElementById("head"+i).classList.add("posthead");
					document.getElementById("post"+i).classList.add("post");
				} else {
					document.getElementById("title"+i).classList.remove("title");
					document.getElementById("head"+i).classList.remove("posthead");
					document.getElementById("post"+i).classList.remove("post");
				}
			}
		} else {
			document.getElementById("title"+(numposts-1)).classList.add("title");
			document.getElementById("head"+(numposts-1)).classList.add("posthead");
			document.getElementById("post"+(numposts-1)).classList.add("post");

			this.style.display = "none";
			thebod.style.backgroundRepeat = "no-repeat, repeat-y";
			downslider.style.display = "block";
			oldman2.pause();
			oldman3.play();
		}
	} 

	downslider.oninput = function() {
		if(this.value < 200){
			thebod.style.backgroundSize = (200 - this.value)+"% "+height+"px, cover";
	    } else {
	    	thebod.style.backgroundSize = "0% 0%, cover"; 
	    	this.style.display = "none";
	    	oldman3.pause();
	    	oldman4.play();
	    	finalslider.style.display = "block";    
	    }
  	}

	finalslider.oninput = function() {
		if(this.value == 0){
			this.style.display = "none"; 
			oldman4.pause();

			document.getElementById("headpic").src = "tenor1.gif"
			
			thebod.style.backgroundSize = "cover";
			thebod.style.backgroundPosition = "50% 100%";
			
			for(i = 0; i < numposts; i++){
				document.getElementById("title"+i).classList.remove("title");
				document.getElementById("head"+i).classList.remove("posthead");
				document.getElementById("post"+i).classList.remove("post");
			}
	
			cycle = setInterval(cycleground, 1);
	
			setTimeout(function() {
				clearInterval(cycle);
				cycle = setInterval(cycleground, 500);
				cycle2 = setInterval(cyclefonts, 150);
				music.play();
			}, 100);
	
	
			setTimeout(function() {
				music.volume = 0.5;
				oldman5.play();	
			}, 2000);

    }
  }

}, false);


/*
slider.addEventListener('input', function(){
	output.innerHTML = slider.value;
});

function changeval(){
	output.innerHTML = slider.value;
}*/
