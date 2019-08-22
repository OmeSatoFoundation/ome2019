#ifndef HTMLPARSER_AS
#define HTMLPARSER_AS
#module

#deffunc htmltag str html, str tag
	exec "htmlparser 1 '" + html + "' " + tag
	return
#deffunc htmltagattr str html, str tag, str attrs
	exec "htmlparser 2 " + html + " " + tag + " " + attrs
	return
#deffunc htmlimg
	exec "htmlparser 3 " + html + " " + tag
	return
#deffunc htmltext
	exec "htmlparser 4 " + html + " " + tag
	return
#deffunc htmllink
	exec "htmlparser 5 " + html + " " + tag
	return
#global
#endif
