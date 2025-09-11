
function pup949273581 () {
	w = 120; h = 400;
	t = (screen.height-h-20)/2; l = (self.screen.width-w)*9/10;
	wd = window.open ('http://by.ru/up?by.ru', 'w949273581', 'location=no,scrollbars=no,status=no,menubar=no,resizable=no,top='+t+',left='+l+',width='+w+',height='+h);
	// if (wd) wd.focus();
	return false;
}

var coo = self.document.cookie;
var ref = self.document.referrer;

if (ref.indexOf('by.ru')<0 && coo.indexOf('browsing=1')<0)
	pup949273581();

document.cookie = "browsing=1; path=/";
