#include "efcgi.h"

static FCGX_Stream *stream_in = NULL;
static FCGX_Stream *stream_out = NULL;
static FCGX_Stream *stream_err = NULL;
static FCGX_ParamArray envp = NULL;

static FCGX_Request request;

void
c_fcgi_flush(void)
{
    FCGX_FFlush(stream_out);
    FCGX_FFlush(stream_err);
}

int 
c_fcgi_accept(void)
{
	return FCGX_Accept(&stream_in, &stream_out, &stream_err, &envp);    
}

void 
c_fcgi_print(EIF_POINTER str)
{
	FCGX_PutStr((char *)str, strlen((char *)str), stream_out);
}

void 
c_fcgi_warn(EIF_POINTER str)
{
	FCGX_PutStr((char *)str, strlen((char *)str), stream_err);
}


EIF_REFERENCE 
c_fcgi_getstr(EIF_INTEGER len)
{
	EIF_REFERENCE str;
	char *buf = (char*) malloc(len);
	FCGX_GetStr(buf, len, stream_in);
	str = eif_string(buf);
	free(buf);
	return str;
}

EIF_REFERENCE 
c_fcgi_getline(EIF_INTEGER len)
{
	EIF_REFERENCE str;
	char *buf = (char*) malloc(len);
	FCGX_GetLine(buf, len, stream_in);
	str = eif_string(buf);
	free(buf);
	return str;
}

void
c_fcgi_finish()
{
	FCGX_Finish();
}


EIF_REFERENCE
c_fcgi_getparam(EIF_POINTER name)
{
	EIF_REFERENCE retval;
	char *temp_param = FCGX_GetParam((char *)name, envp);
	if (temp_param == NULL) temp_param = "";
	
	retval = eif_string(temp_param);
	return retval;
}

EIF_POINTER
c_fcgx_init_request(EIF_INTEGER sock, EIF_INTEGER flags)
{
	int result; 
	result = FCGX_InitRequest(&request, (int)sock, (int)flags);
	return (result == 0) ? (EIF_POINTER) &request : (EIF_POINTER) NULL;
}

EIF_INTEGER
c_fcgx_init(void)
{
	return (EIF_INTEGER) FCGX_Init();
}
