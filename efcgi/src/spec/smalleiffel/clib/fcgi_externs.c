#include "fcgiapp.h"
#include <stdio.h>

#ifndef FALSE
#define FALSE (0)
#endif

#ifndef TRUE
#define TRUE  (1)
#endif


extern char **environ;
static char **requestEnviron = NULL;

static int acceptCalled = FALSE;
static int finishCalled = FALSE;
static int isCGI = FALSE;
static FCGX_Stream *stream_in = NULL;
/*static SV *svout = NULL, *svin, *sverr; */
static FCGX_Stream *stream_out = NULL, *stream_err = NULL;


static void
FCGI_Flush(void)
{
    if(!acceptCalled || isCGI) {
	return;
    }
    FCGX_FFlush(stream_out);
    FCGX_FFlush(stream_err);
}



static int 
FCGI_Accept(void)
{
    if(!acceptCalled) {
        /*
         * First call to FCGI_Accept.  Is application running
         * as FastCGI or as CGI?
         */
        isCGI = FCGX_IsCGI();
    } else if(isCGI) {
        /*
         * Not first call to FCGI_Accept and running as CGI means
         * application is done.
         */
        return(EOF);
    } else {
	if(!finishCalled) {
	    FCGI_Flush();
	}
    }
    if(!isCGI) {
        FCGX_ParamArray envp;
        int acceptResult = FCGX_Accept(&stream_in, &stream_out, 
				       &stream_err, &envp);
        if(acceptResult < 0) {
            return acceptResult;
        }
	finishCalled = FALSE;
        environ = envp;
    }
    acceptCalled = TRUE;
    return 0;
}


static void 
FCGI_Finish(void)
{
    if(!acceptCalled || isCGI) {
	return;
    }
    FCGI_Flush();
    stream_in = NULL;
    FCGX_Finish();
    /*
    environ = NULL;
    */
    finishCalled = TRUE;
}


int
fcgi_accept()
{
   char **savedEnviron;
   int acceptStatus;
   char db[444];
   
   requestEnviron = NULL;
   /*
    * Call FCGI_Accept but preserve environ.
    */
   savedEnviron = environ;
   acceptStatus = FCGI_Accept();
   requestEnviron = environ; /* the new environ */
   environ = savedEnviron; /* the old environ */
   /*
    * Make Eiffel variable settings for the new request.
    */
   if(acceptStatus >= 0 && !FCGX_IsCGI()) {} 
   else {
      requestEnviron = NULL;
   }
   return acceptStatus;
}

void fcgi_print(char *str)
{
   if (!isCGI) {
      FCGX_PutStr(str, strlen(str), stream_out);
   }
   else {
      printf("%s", str);
   }
}

void fcgi_warn(char *str)
{
   if (!isCGI) {
      FCGX_PutStr(str, strlen(str), stream_err);
   }
   else {
      fprintf(stderr, "%s", str);
   }
}


char* fcgi_read(int len)
{
   int retval;
   char *buf = (char*) malloc(len);
   FCGX_GetStr(buf, len, stream_in);
   return buf;
}


void
fcgi_finish()
{
   requestEnviron = NULL;
   /*
    * Finish the request.
    */
   FCGI_Finish();
}


char* fcgi_getenv(char *name)
{
   /* return a copy to avoid problems with keeping the result */
   char *retval;
   char *temp_param = FCGX_GetParam(name, requestEnviron);
   if (temp_param == NULL) temp_param = "";
   
   retval = (char *) malloc(strlen(temp_param) + 1);
   strcpy(retval, temp_param);
   return retval;
}


void
fcgi_flush()
{
   FCGI_Flush();
}


/*int main()
{
   if (fcgi_accept() >= 0) {
      fcgi_print("fuck you\n");
   }
}
*/
