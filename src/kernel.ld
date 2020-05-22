SECTIONS
{
    /* qemu kernel load base address */
	. = 0x40000000;
	.text : { *(.text) }
	.data : { *(.data) }
	.bss : { *(.bss) }
}

