#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif

#ifdef _WIN32
#include <process.h>
#endif

#include "fcgiapp.h"

#include <stdio.h>

#include "eif_cecil.h"
#include "eif_hector.h"

extern void c_fcgi_flush(void);
extern int c_fcgi_accept(void);
extern void c_fcgi_print(EIF_POINTER str);
extern void c_fcgi_warn(EIF_POINTER str);
extern EIF_REFERENCE c_fcgi_getstr(EIF_INTEGER len);
extern EIF_REFERENCE c_fcgi_getline(EIF_INTEGER len);
extern void c_fcgi_finish();
extern EIF_REFERENCE c_fcgi_getparam(EIF_POINTER name);
extern EIF_POINTER c_fcgx_init_request(EIF_INTEGER sock, EIF_INTEGER flags);
extern EIF_INTEGER c_fcgx_init(void);