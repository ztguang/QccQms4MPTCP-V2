
//vim src/iperf_locale.c
                           "Client specific:\n"
                           "  --qoe      #              QoE parameter passed to Android Kernel\n"	// add the line

//vim src/iperf_api.h
	#define OPT_BIDIRECTIONAL 20
	#define OPT_QOE 300	/* QoE parameter passed to Android Kernel */					// add the line

	/* states */

//vim src/iperf.h
	struct iperf_test
	{
	    unsigned char qoe;		/* QoE parameter passed to Android Kernel */			// add the line
	}

//vim src/iperf_api.c
	iperf_defaults(struct iperf_test *testp)
	{
	    testp->qoe = 0;		/* QoE parameter passed to Android Kernel */				// add the line
	    testp->omit = OMIT;
	}

//vim src/iperf_api.c
	iperf_parse_arguments(struct iperf_test *test, int argc, char **argv)
	{
	    static struct option longopts[] =
	    {
	        {"qoe", required_argument, NULL, OPT_QOE},		/* QoE parameter passed to Android Kernel */		// add the line
	    }

		    case OPT_QOE:		/* QoE parameter passed to Android Kernel */					// add the following three lines
		        test->qoe = atoi(optarg);
		        break;
		    case 'h':
		    default:
		        usage_long();
		        exit(1);
	}

//vim src/iperf_tcp.c
	iperf_tcp_connect(struct iperf_test *test)
	{
	    ( (struct sockaddr_in *) server_res->ai_addr)->sin_zero[7] = test->qoe;		/* QoE parameter passed to Android Kernel */	// add the line
	    if (connect(s, (struct sockaddr *) server_res->ai_addr, server_res->ai_addrlen) < 0 && errno != EINPROGRESS) {
	}


//vim src/iperf_api.c
            //tempdir = "/tmp";
            tempdir = "/data/local/tmp";


//vim src/iperf_config.h
	//#define HAVE_SSL 1		//delete the line


//vim Android.bp
	    name: "iperf3qoe",


