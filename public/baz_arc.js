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
dl=$(location).attr('href'),
dest = 'http://localhost:3000/products/new',
total = dest + '?l=' + l;
location.href = total;
}
