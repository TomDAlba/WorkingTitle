function make_count( this_p ){

console.debug( this_p );
    var data = this_p.html();
    var new_data = parseInt(data);

    if( this_p.attr('data-voted') == '1' ){

        new_data = new_data - 1;
        this_p.attr('data-voted', '0');
        this_p.parents('.click_like').removeClass('voted_cl');
    }else{
        new_data = new_data + 1;
        this_p.attr('data-voted', '1');
        this_p.parents('.click_like').addClass('voted_cl');
        $.ajax({ url :'/posts/add_like',
                 type: 'POST',
                 data: {'id' : this_p.attr('data-id') ,'authenticity_token' : $('[name="csrf-token"]').attr('content')}
                });
    }
    console.debug( this_p );
    //console.log( new_data );
    this_p.html( ' '+new_data );


}
function SetCookie(cookieName,cookieValue,nDays) {
 var today = new Date();
 var expire = new Date();
 if (nDays==null || nDays==0) nDays=1;
 expire.setTime(today.getTime() + 3600000*24*nDays);
 document.cookie = cookieName+"="+escape(cookieValue)
                 + ";expires="+expire.toGMTString();
}