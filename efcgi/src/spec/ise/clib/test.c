#include "efcgi.h"

void
main(void)
{
	int sock, count;
	FCGX_Request request;

	count = 0;

	FCGX_Init();
	sock = FCGX_OpenSocket(":8000", 5);
	printf("Socket: %d", sock);
	FCGX_InitRequest(&request, sock, 0);
	while (FCGX_Accept_r(&request) == 0)
	{
		FCGX_FPrintF(request.out,
           "Content-type: text/html\r\n"
           "\r\n"
           "<title>FastCGI Hello! (C, fcgiapp library)</title>"
           "<h1>FastCGI Hello! (C, fcgiapp library)</h1>"
           "Request number %d running on host <i>%s</i>  "
           "Process ID: %d\n",
           ++count, FCGX_GetParam("SERVER_NAME", request.envp), getpid());
	}
}