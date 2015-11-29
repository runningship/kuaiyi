
/* gotoScroll */
function scrollTo(a,t,callback){
    if(!a){a=$('.mainer')}
    //scrollTops=a.children(0).innerHeight() - a.innerHeight();
    //a.animate({scrollTop: 60},300,callback);
    a.scrollTop(99999);
}
/* Hv action */
function setHvData(name,value){
    if(window.localStorage){
        localStorage.setItem(name,value);
    }else{
        alert('不支持？');
    }
}
function getHvData(name){
    if(window.localStorage){
        return localStorage.getItem(name);
    }else{
        alert('不支持？');
    }
}
function reHvData(name){
    if(window.localStorage){
        return localStorage.removeItem(name);
    }else{
        alert('不支持？');
    }
}
/* 实时备份输入框内容 */
function contentIndexIng(){
    $('.content').on('input',function(){
        setHvData('me-you',$(this).html())
    })
}
/* 读取用户信息并显示在消息区 */
function contentSetVal(){
    var val=getHvData('me-you');
    if(val){$('.content').html(val)}
}
/* 删除用户信息 */
function contentReVal(){
    reHvData('me-you');
}

/* 判断文本框获取焦点 */
function ifContFocus(){
    var C=$('.content'),
    R=$('.submit');
    C.on('input',function(){
        if($(this).text()){
            R.addClass('focus');
        }else{
            R.removeClass('focus');
        }
    })
    if(C.text()){
        R.addClass('focus');
    }else{
        R.removeClass('focus');
    }
    C.focus();
    scrollTo();
}
$(document).ready(function() {

ifContFocus();
scrollTo();

contentIndexIng();
contentSetVal();
});


/* 聊天功能  */
var myName='御龙',
myFace='龙',
youName='',
youFace='';
function setChatList(v){
	v = v.replace(/div/g ,'span')
var str='<li class="M">'
    +'<div class="B">'
    +'<strong>'
    +myName
    +'</strong>'
    +'<p>'
    +v
    +'</p>'
    +'</div>'
    +'<div class="A">'
    +'<span>'
    +myFace
    +'</span>'
    +'</div>'
    +'</li>';
    return str;
}
$(document).on('click touch', '.submit', function(event) {
    var Thi=$(this),
    content=$('.content'),
    contentVal=content.html();
    if(contentVal){
        //layer.msg(content.val());
        var EnCodeVal=contentVal//HtmlEncode(contentVal);
        //alert(EnCodeVal)
        $('.mainer').children(0).append(setChatList(EnCodeVal))

        content.html('');
        content.focus();
        scrollTo();
        contentReVal();
    }
    event.preventDefault();
    /* Act on the event */
});

function sendMsg(msg){
	var content=$('.content');
	$('.mainer').children(0).append(setChatList(msg))
    //content.html('');
    //content.focus();
    scrollTo();
}



/* 表情图片区 */
function insertHtmlAtCaret(html) {
    if(html){
    var html=html;
    var sel, range;
    if (window.getSelection) {
        // IE9 and non-IE
        sel = window.getSelection();
        if (sel.getRangeAt && sel.rangeCount) {
            range = sel.getRangeAt(0);
            range.deleteContents();
            // Range.createContextualFragment() would be useful here but is
            // non-standard and not supported in all browsers (IE9, for one)
            var el = document.createElement("div.content");
            el.innerHTML = html;
            var frag = document.createDocumentFragment(), node, lastNode;
            while ( (node = el.firstChild) ) {
                lastNode = frag.appendChild(node);
            }
            range.insertNode(frag);
            // Preserve the selection
            if (lastNode) {
                range = range.cloneRange();
                range.setStartAfter(lastNode);
                range.collapse(true);
                sel.removeAllRanges();
                sel.addRange(range);
            }
        }
    }
    }
}
$(document).on('click touch', function(event) {
    $('.chatExpBox').removeClass('show');
});
$(document).on('click touch', '.btnExp,.chatExpBox', function(event) {
    var Thi=$(this),
    expBox=$('.chatExpBox'),
    content=$('.content');
    if(!expBox.hasClass('show')){
        expBox.addClass('show');
    }
    return false;
    event.preventDefault();
    /* Act on the event */
});
$(document).on('click touch', '.chatExpBox img', function(event) {
    var Thi=$(this),
    content=$('.content'),
    faces=Thi.prop("outerHTML");
//    layer.msg(Thi.attr('src'));
//content.val(Thi.prop("outerHTML"))
insertHtmlAtCaret(faces)
    return false;
    event.preventDefault();
    /* Act on the event */
});
