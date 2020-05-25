
#ifndef __ASM_SYSREG_H
#define __ASM_SYSREG_H

#include <const.h>

#define SCTLR_EL1_RES1	((_BITUL(11)) | (_BITUL(20)) | (_BITUL(22)) | (_BITUL(28)) | \
			 (_BITUL(29)))
#define SCTLR_EL1_RES0  ((_BITUL(6))  | (_BITUL(10)) | (_BITUL(13)) | (_BITUL(17)) | \
			 (_BITUL(27)) | (_BITUL(30)) | (_BITUL(31)) | \
			 (0xffffefffUL << 32))

#define ENDIAN_SET_EL1	0

#endif	/* __ASM_SYSREG_H */
