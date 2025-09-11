function OpenCenterWdw(urlname,windowname,width,height)
{
 var hheight= (screen.height-height)/2;
 var hleft= (screen.width-width)/2;
 window.open(urlname,''+windowname+'','top='+hheight+',left='+hleft+',height='+height+',width='+width+',status=0,scrollbars=0,toolbar=0,resizable=1,menubar=0,titlebar=1');
}
//-----------------------------
function CloseRedirectWdw(urlname)
{
window.opener.document.location.href=urlname;
window.close();
}
//-----------------------------
function swapem(oname, nname) {
	if (document.images){
	oname.src = nname.src
	}
}
//-----------------------------
function change(sel1, sel2){
    if (sel1.length > 0){
        var ind = 0;
        while (ind<sel1.length) {
  	      if (sel1.options[ind].selected) {
			var len1 = sel1.length;
        		var len2 = sel2.length;
        		sel2.options[len2] = new Option(sel1.options[ind].text, sel1.options[ind].value, false, false);
		        sel2.options[len2].text = sel1.options[ind].text;
		        sel2.options[len2].value = sel1.options[ind].value;
		        sel1.options[ind] = null;
		} else {
			ind++;
		}
	}
    }
}    
//-----------------------------
function add_biblos(){
   if (document.forms){
	  change(document.forms[document.forms.length -1].not_biblos, document.forms[document.forms.length -1].ff_biblos);
   }    
}
//-----------------------------
function selectall_inselectbox (box) {
    if (box){
        for (i=0; i < box.length; i++){
            if (box.options){
                box.options[i].selected = 1;
            }    
        }
    }
}
//-----------------------------
function hero_save(){
    if (document.forms){
        selectall_inselectbox(document.forms[document.forms.length -1].ff_biblos);
        document.forms[document.forms.length -1].submit();
    }
}    
//-----------------------------
function all_save(){
    if (document.forms){
        selectall_inselectbox(document.forms[document.forms.length -1].profs_right);
        selectall_inselectbox(document.forms[document.forms.length -1].naci_right);
        selectall_inselectbox(document.forms[document.forms.length -1].place_right);
        document.forms[document.forms.length -1].submit();
    }
}    

