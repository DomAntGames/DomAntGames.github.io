//This really isn't that funny.
let c = {};
let n = 0;
c[n++]= "Whatever it was, it's gone now.";
c[n++]= "Good riddance?";
c[n++]= "Welp.";
c[n++]= "Somewhere it goes.";
c[n++]= "Hopefully it wasn't anything important.";
c[n++]= "Oh well.";
c[n++]= "What was it?";
c[n++]= "Sorry, that's on us.";
c[n++]= "That's that.";
c[n++]= "Web content is not our problem.";
c[n++]= "Huh.";
c[n++]= "Here we go again.";
c[n++]= "What was this place?";
let num=Math.floor(Math.random() * n); 
document.write( "<small>\""+c[num]+"\"</small>" );