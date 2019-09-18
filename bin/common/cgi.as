#ifndef CGI_AS
#define CGI_AS
#include "cmdexec.as"
#module
qsize = 0
#deffunc getquerystr var querystr
    creattmp tmpfile
    exec "echo $QUERY_STRING > " + tmpfile
    cmdexec "decurl.py " + tmpfile, query
    split query, "&", querystr  
    qsize = stat
    return 
#deffunc getqueryval str key, var val
    creattmp tmpfile
    exec "echo $QUERY_STRING > " + tmpfile
    cmdexec "decurl.py " + tmpfile, query
    split query, "&", querystr 
    qsize = stat
    found = 0
    split querystr, "=", qstr
    repeat qsize
        p = instr(qstr(cnt), 0, key)
        if(p != -1) {
            found = 1
            break
        } 
    loop
    if(found) {
        val = qstr(cnt+1) 
    } else {
        val = ""
    }
    return
#global
#endif
