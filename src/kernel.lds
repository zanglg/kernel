#include <mem-map.h>

SECTIONS
{
	/* qemu kernel load base address */
	. = VIRT_MEM;
	.head.text : { *(.head.text) }
	.text : { *(.text) }
	.data : { *(.data) }
	.bss : { *(.bss) }
}

