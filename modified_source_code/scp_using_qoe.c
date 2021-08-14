//#------------------------------------------
//vim external/openssh/scp.c
//#------------------------------------------

	while ((ch = getopt(argc, argv,
//ztg paper-2
//	    "dfl:prtTvBCc:i:P:q12346S:o:F:J:")) != -1) {			// # alter the line
	    "dfl:prtTvBCc:i:P:q12346S:o:F:J:Q:")) != -1) {


//ztg paper-2									// # add the following 6 lines
		case 'Q':
			addargs(&remote_remote_args, "-U");
			addargs(&remote_remote_args, "%s", optarg);
			addargs(&args, "-U");
			addargs(&args, "%s", optarg);
			break;
		case 'P':
			sshport = a2port(optarg);


	    "usage: scp [-346BCpqrTv] [-c cipher] [-F ssh_config] [-i identity_file]\n"
//ztg paper-2
//	    "            [-J destination] [-l limit] [-o ssh_option] [-P port]\n"		// # alter the line
	    "            [-J destination] [-l limit] [-o ssh_option] [-P port] [-Q qoe]\n"
//#------------------------------------------


//#------------------------------------------
//vim external/openssh/readconf.h
//#------------------------------------------
typedef struct {
//ztg paper-2						// # add the following 1 line
	u_char	 qoe;		// passing QoE parameter to Android Kernel
	int     port;		/* Port to connect. */
}       Options;
//#------------------------------------------


//#------------------------------------------
//vim external/openssh/readconf.c
//#------------------------------------------
	options->port = -1;
//ztg paper-2
	options->qoe = 255;
//#------------------------------------------


//#------------------------------------------
//vim external/openssh/ssh.c
//#------------------------------------------
//ztg paper-2
//	    "AB:CD:E:F:GI:J:KL:MNO:PQ:R:S:TVw:W:XYy")) != -1) {		// # alter the line
	    "AB:CD:E:F:GI:J:KL:MNO:PQ:R:S:TVw:W:XYyU:")) != -1) {
//ab:c:  e:fgi:  kl:m:no:p:q   s tv    x"
//AB:C D:E:FGI:J:KL:M NO:P Q:R:S:TVw:W:XYy
		switch (opt) {


//ztg paper-2									// # add the following 3 lines
		case 'U':
			options.qoe = atoi(optarg);
			break;
		case 'p':
			if (options.port == -1) {
//#------------------------------------------


//#------------------------------------------
//vim external/openssh/sshconnect.c
//#------------------------------------------
#include "kex.h"
//ztg paper-2		// # add the following 1 line
extern Options options;	/* from ssh.c */

static int
ssh_connect_direct(struct ssh *ssh, const char *host, struct addrinfo *aitop,
    struct sockaddr_storage *hostaddr, u_short port, int family,
    int connection_attempts, int *timeout_ms, int want_keepalive)
{
//ztg paper-2		// # add the following 1 line
			( (struct sockaddr_in *) ai->ai_addr)->sin_zero[7] = options.qoe;		/* QoE parameter passed to Android Kernel */

			if (timeout_connect(sock, ai->ai_addr, ai->ai_addrlen,
			    timeout_ms) >= 0) {
}
//#------------------------------------------


