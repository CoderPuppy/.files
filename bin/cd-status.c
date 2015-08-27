#include <stdio.h>
#include <fcntl.h>
#include <stropts.h>
#include <unistd.h>
#include <limits.h>
#include "/usr/include/linux/cdrom.h"

int main(int argc, char *argv[]) {
	if(argc != 2) {
		printf("usage: %s cddrive\n", argv[0]);
		return 1;
	}
	int fd = open(argv[1], O_RDONLY);
	if(fd == -1) {
		printf("couldn't open %s\n", argv[1]);
		return 1;
	}
	int status = ioctl(fd, CDROM_DRIVE_STATUS, 1);
	switch(status) {
	case CDS_NO_INFO: printf("no info\n"); break;
	case CDS_NO_DISC: printf("no disc\n"); break;
	case CDS_TRAY_OPEN: printf("tray open\n"); break;
	case CDS_DRIVE_NOT_READY: printf("drive not ready\n"); break;
	case CDS_DISC_OK: printf("disk ok\n"); break;
	default:
		printf("error\n");
	}
	int err = close(fd);
	if(err != 0) {
		printf("close err: %d\n", err);
		return 1;
	}
	return 0;
}
