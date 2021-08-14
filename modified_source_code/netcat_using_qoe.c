
//vim netcat.c

/* Command Line Options */
unsigned char qoe = 0;			/* QoE parameter passed to Android Kernel */	// # add the line


//	    "46DdhI:i:jklnO:P:p:rSs:tT:UuV:vw:X:x:z")) != -1) {				// # alter the line as the following line
	    "46DdhI:i:jklnO:P:p:q:rSs:tT:UuV:vw:X:x:z")) != -1) {


		case 'q':										// # add the following three lines
			qoe = atoi(optarg);
			break;
		case 'r':


	( (struct sockaddr_in *) name)->sin_zero[7] = qoe;	/* QoE parameter passed to Android Kernel */	// # add the line
	if ((ret = connect(s, name, namelen)) != 0 && errno == EINPROGRESS) {


	\t-p port\t	Specify local port for remote connects\n\
	\t-q QoE\t	QoE parameter passed to Android Kernel\n\							// # add the line


//vim Android.mk
	LOCAL_MODULE:=qoe_nc


