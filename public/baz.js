function post_some_shit() {
// $.ajax({
//        type: "POST",
     // url: "/products/",
      //  data: "l=test",
    //    dataType: 'text',
  //      success: function(){
//	alert('Yes!')
    //    }
  //    });
//
 //     };

 
// post_some_shit();


if (typeof jQuery == 'undefined') {
	var jQ = document.createElement('script');
	jQ.type = 'text/javascript';
	jQ.onload=runthis;
	jQ.src = 'http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js';
	document.body.appendChild(jQ);
} else {
	runthis();
}

function runthis() {
$.ajax({url: '/products',
        type:'POST',
        data: 'l=test',
        dataType: 'script'})

    };

}
