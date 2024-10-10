//This really isn't that funny.
let c = {};
let n = 0;
c[n++]= "Web design is not our passion.";
c[n++]= "Thank you for reading?";
c[n++]= "Probably.";
c[n++]= "Yes.";
c[n++]= "Close the browser tab on your way out.";
c[n++]= "So it goes.";
c[n++]= "Oh.";
c[n++]= "Sorry for the trouble.";
c[n++]= "Zzz...";
c[n++]= "Sorry for the trouble.";
c[n++]= "Maybe next time.";
c[n++]= "Here we go again.";
c[n++]= "What is this place?";
let num=Math.floor(Math.random() * n); 
document.write( "<small>\""+c[num]+"\"</small>" );