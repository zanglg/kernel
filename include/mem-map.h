#ifndef __MEM_MAP
#define __MEM_MAP

/* clang-format off */
#define VIRT_FLASH        0x00000000
#define VIRT_GIC_DIST     0x08000000
#define VIRT_GIC_CPU      0x08010000
#define VIRT_GIC_V2M      0x08020000
#define VIRT_GIC_HYP      0x08030000
#define VIRT_GIC_VCPU     0x08040000
#define VIRT_GIC_ITS      0x08080000
#define VIRT_GIC_REDIST   0x080A0000
#define VIRT_UART         0x09000000
#define VIRT_RTC          0x09010000
#define VIRT_FW_CFG       0x09020000
#define VIRT_GPIO         0x09030000
#define VIRT_SECURE_UART  0x09040000
#define VIRT_SMMU         0x09050000
#define VIRT_PCDIMM_ACPI  0x09070000
#define VIRT_ACPI_GED     0x09080000
#define VIRT_MMIO         0x0a000000
#define VIRT_PLATFORM_BUS 0x0c000000
#define VIRT_SECURE_MEM   0x0e000000
#define VIRT_PCIE_MMIO    0x10000000
#define VIRT_PCIE_PIO     0x3eff0000
#define VIRT_PCIE_ECAM    0x3f000000
#define VIRT_MEM          0x40000000
/* clang-format on */

#endif /* __MEM_MAP */
