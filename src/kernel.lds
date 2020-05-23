#include <mem-map.h>

SECTIONS
{
	/* qemu kernel load base address */
	. = VIRT_MEM;
	.text : { *(.text) }
	.data : { *(.data) }
	.bss : { *(.bss) }
}

