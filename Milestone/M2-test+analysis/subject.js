var fs = require("fs");
function inc(p, q){
   if(q ==null) q =1;
   // var a=5;
   // if(a>5){
   // 	   var b=0;
   // 	   if (b>3)
   // 		   q++;
   // 	   else if (b<-1)
   // 		   b++;
   // 	   p++;
   // }
   if( p < 0 )
   {
	   p = -p;
   }
   return p + q/q;
}

exports.inc = inc;

