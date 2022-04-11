#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <stdbool.h>
#include <libftdi1/ftdi.h>

/* Even on 93xx66 at max 256 bytes are used (AN_121)*/
#define FTDI_MAX_EEPROM_SIZE 256

/* lifted from src/ftdi_i.h in libftdi source code */
struct ftdi_eeprom
{
    /** vendor id */
    int vendor_id;
    /** product id */
    int product_id;

    /** Was the eeprom structure initialized for the actual
        connected device? **/
    int initialized_for_connected_device;

    /** self powered */
    int self_powered;
    /** remote wakeup */
    int remote_wakeup;

    int is_not_pnp;

    /* Suspend on DBUS7 Low */
    int suspend_dbus7;

    /** input in isochronous transfer mode */
    int in_is_isochronous;
    /** output in isochronous transfer mode */
    int out_is_isochronous;
    /** suspend pull downs */
    int suspend_pull_downs;

    /** use serial */
    int use_serial;
    /** usb version */
    int usb_version;
    /** Use usb version on FT2232 devices*/
    int use_usb_version;
    /** maximum power */
    int max_power;

    /** manufacturer name */
    char *manufacturer;
    /** product name */
    char *product;
    /** serial number */
    char *serial;

    /* 2232D/H specific */
    /* Hardware type, 0 = RS232 Uart, 1 = 245 FIFO, 2 = CPU FIFO,
       4 = OPTO Isolate */
    int channel_a_type;
    int channel_b_type;
    /*  Driver Type, 1 = VCP */
    int channel_a_driver;
    int channel_b_driver;
    int channel_c_driver;
    int channel_d_driver;
    /* 4232H specific */
    int channel_a_rs485enable;
    int channel_b_rs485enable;
    int channel_c_rs485enable;
    int channel_d_rs485enable;

    /* Special function of FT232R/FT232H devices (and possibly others as well) */
    /** CBUS pin function. See CBUS_xxx defines. */
    int cbus_function[10];
    /** Select hight current drive on R devices. */
    int high_current;
    /** Select hight current drive on A channel (2232C */
    int high_current_a;
    /** Select hight current drive on B channel (2232C). */
    int high_current_b;
    /** Select inversion of data lines (bitmask). */
    int invert;
    /** Enable external oscillator. */
    int external_oscillator;

    /*2232H/4432H Group specific values */
    /* Group0 is AL on 2322H and A on 4232H
       Group1 is AH on 2232H and B on 4232H
       Group2 is BL on 2322H and C on 4232H
       Group3 is BH on 2232H and C on 4232H*/
    int group0_drive;
    int group0_schmitt;
    int group0_slew;
    int group1_drive;
    int group1_schmitt;
    int group1_slew;
    int group2_drive;
    int group2_schmitt;
    int group2_slew;
    int group3_drive;
    int group3_schmitt;
    int group3_slew;

    int powersave;

    int clock_polarity;
    int data_order;
    int flow_control;

    /** user data **/
    int user_data_addr;
    int user_data_size;
    const char *user_data;

    /** eeprom size in bytes. This doesn't get stored in the eeprom
        but is the only way to pass it to ftdi_eeprom_build. */
    int size;
    /* EEPROM Type 0x46 for 93xx46, 0x56 for 93xx56 and 0x66 for 93xx66*/
    int chip;
    unsigned char buf[FTDI_MAX_EEPROM_SIZE];

    /** device release number */
    int release_number;
};

int main(int argc, char **argv)
{
	struct ftdi_context *context;
	char buf[FTDI_MAX_EEPROM_SIZE];
	unsigned short checksum, value;
	unsigned int addr, val;
	bool changed = false;
	int i, retval = 0;

	if (argc < 3) {
		fprintf(stdout,
			"Usage: %s d:<bus>/<dev> 0x<offset>=0x<value> ...\n",
			argv[0]);
		return EXIT_FAILURE;
	}

	if ((context = ftdi_new()) == 0) {
		fprintf(stderr, "new failed: %s\n",
			ftdi_get_error_string(context));
		return EXIT_FAILURE;
	}

	if (ftdi_usb_open_string(context, argv[1])) {
		fprintf(stderr, "open failed: %s\n",
			ftdi_get_error_string(context));
		retval = EXIT_FAILURE;
		goto free;
	}

	if (ftdi_read_eeprom(context)) {
		fprintf(stderr, "read_eeprom failed: %s\n",
			ftdi_get_error_string(context));
		retval = EXIT_FAILURE;
		goto close;
	}

	if (ftdi_get_eeprom_buf(context, buf, sizeof(buf))) {
		fprintf(stderr, "get_eeprom_buf failed: %s\n",
			ftdi_get_error_string(context));
		retval = EXIT_FAILURE;
		goto close;
	}

	for (i = 2; i < argc; i++) {
		if (sscanf(argv[i], "0x%x=0x%x", &addr, &val) < 2) {
			fprintf(stderr, "skipping: %s\n", argv[i]);
			continue;
		}
		fprintf(stdout, "assigning eeprom[%#2x] %#0.2x => %#0.2x\n",
			addr, buf[addr], val);
		if (buf[addr] != val)
			changed = true;
		buf[addr] = val;
	}

	if (!changed) {
		fprintf(stdout, "no changes\n");
		goto close;
	}

	/* calculate checksum */
	checksum = 0xAAAA;
	for (i = 0; i < context->eeprom->size/2-1; i++) {
		value = buf[i*2] | (buf[(i*2)+1] << 8);	    /* little endian */
		checksum = value^checksum;			      /* xor */
		checksum = (checksum << 1) | (checksum >> 15); /* shift left */
	}
	fprintf(stdout, "checksum %#0.4x => %#0.4x\n",
		buf[context->eeprom->size-2] |
		buf[context->eeprom->size-1] << 8, checksum);
	buf[context->eeprom->size-2] = checksum;
	buf[context->eeprom->size-1] = checksum >> 8;

	if (ftdi_set_eeprom_buf(context, buf, sizeof(buf))) {
		fprintf(stderr, "set_eeprom failed: %s\n",
			ftdi_get_error_string(context));
		retval = EXIT_FAILURE;
		goto close;
	}

	context->eeprom->size = 0x80;
	context->eeprom->initialized_for_connected_device = 1;

	if (ftdi_write_eeprom(context)) {
		fprintf(stderr, "write_eeprom failed: %s\n",
			ftdi_get_error_string(context));
		retval = EXIT_FAILURE;
		goto close;
	}

close:
	ftdi_usb_close(context);
free:
	ftdi_free(context);
	return retval;
}
