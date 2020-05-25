#include <asm/assembler.h>
#include <asm/sysreg.h>

.section ".head.text","ax"
_start:
	b	stext
	.long	0

stext:
	bl      el2_setup                       // Drop to EL1, w0=cpu_boot_mode

el2_setup:
	msr	SPsel, #1			// We want to use SP_EL{1,2}
	mrs	x0, CurrentEL
	cmp	x0, #(2 << 2)
	b.eq	deadloop
	mov_q	x0, (SCTLR_EL1_RES1 | ENDIAN_SET_EL1)
	msr	sctlr_el1, x0
	isb
	ret

deadloop:
	wfi
	wfe
	b	deadloop
