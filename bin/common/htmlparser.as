#ifndef HTMLPARSER_AS
#define HTMLPARSER_AS
#include "cmdexec.as"
#module

#deffunc htmltag str html, str tag, var v
	creattmp _t
	notesel _buf
	noteadd html
	notesave _t
	cmdexec "htmlparser 1 " + _t + " " + tag, v
	deltmp _t
	return
#deffunc htmltagattr str html, str tag, str attrs, var v
	creattmp _t
	notesel _buf
	noteadd html
	notesave _t
	cmdexec "htmlparser 2 " + _t + " " + tag + " " + attrs, v
	deltmp _t
	return
#deffunc htmlimg str html, str tag, var v
	creattmp _t
	notesel _buf
	noteadd html
	notesave _t
	cmdexec "htmlparser 3 " + _t + " " + tag, v
	deltmp _t
	return
#deffunc htmltext str html, str tag, var v
	creattmp _t
	notesel _buf
	noteadd html
	notesave _t
	cmdexec "htmlparser 4 " + _t + " " + tag, v
	deltmp _t
	return
#deffunc htmllink str html, str tag, var v
	creattmp _t
	notesel _buf
	noteadd html
	notesave _t
	cmdexec "htmlparser 5 " + _t + " " + tag, v
	deltmp _t
	return
#global
#endif
