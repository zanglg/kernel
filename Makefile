
TARGET    := kernel

SRC_DIRS  := src
INC_DIRS  := include
OUT_DIRS  := build

SRCS      := $(shell find $(SRC_DIRS) -name *.c -or -name *.S)
OBJS      := $(SRCS:%=$(OUT_DIRS)/%.o)

LINK_SRC  := $(SRC_DIRS)/$(TARGET).lds
LINK_OUT  := $(OUT_DIRS)/$(TARGET).ld

INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CC         = aarch64-linux-gnu-gcc
AS         = aarch64-linux-gnu-gcc
CXX        = aarch64-linux-gnu-g++
LD         = aarch64-linux-gnu-ld
OBJCOPY    = aarch64-linux-gnu-objcopy

CFLAGS    := -Wall -Werror -nostdlib -nostartfiles -ffreestanding -mgeneral-regs-only
ASFLAGS   := -D__ASSEMBLY__

all: $(OUT_DIRS)/$(TARGET)
$(OUT_DIRS)/$(TARGET): make-build-dirs $(LINK_OUT) $(OBJS)
	$(LD) -T $(LINK_OUT) $(OBJS) -o $@.elf
	$(OBJCOPY) $@.elf -O binary $@

$(OUT_DIRS)/%.c.o: %.c
	@test -d $(dir $@) || mkdir -pm 755 $(dir $@)
	$(CC) $(CFLAGS) $(INC_FLAGS) -c $< -o $@

$(OUT_DIRS)/%.S.o: %.S
	@test -d $(dir $@) || mkdir -pm 755 $(dir $@)
	$(CC) $(ASFLAGS) $(INC_FLAGS) -c $< -o $@

$(LINK_OUT): $(LINK_SRC)
	@test -d $(OUT_DIRS) || mkdir -pm 755 $(OUT_DIRS)
	$(CXX) $(ASFLAGS) $(INC_FLAGS) -E -x c -P $< -o $@

clean:
	@$(RM) -r $(OUT_DIRS)
	@echo "Build directory removed."

run: all
	@echo
	@echo "Press Ctrl-A and then X to exit QEMU"
	@echo
	qemu-system-aarch64 \
		-machine virt -cpu cortex-a53 -smp 2 -m 1024 \
		-nographic -serial mon:stdio -kernel $(OUT_DIRS)/$(TARGET)

.PHONY: make-build-dirs clean run
