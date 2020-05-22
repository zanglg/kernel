
TARGET := kernel

SRC_DIRS := src
INC_DIRS := include
OUT_DIRS := build

IMAGE := $(OUT_DIRS)/$(TARGET)
LINK_SCRIPT := $(SRC_DIRS)/$(TARGET).ld

SRCS := $(shell find $(SRC_DIRS) -name *.c -or -name *.S)
OBJS := $(SRCS:%=$(OUT_DIRS)/%.o)

INC_FLAGS := $(addprefix -I,$(INC_DIRS))

CC = aarch64-linux-gnu-gcc
AS = aarch64-linux-gnu-gcc
LD = aarch64-linux-gnu-ld
OBJCOPY = aarch64-linux-gnu-objcopy

CFLAGS = -nostdlib -nostartfiles -ffreestanding -mgeneral-regs-only \
		 $(INC_FLAGS)
ASFLAGS = $(INC_FLAGS)
LDFLAGS = -T $(LINK_SCRIPT)

all: $(IMAGE).img
$(IMAGE).img: $(IMAGE).elf
	$(OBJCOPY) $< -O binary $@

$(IMAGE).elf: $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@

$(OUT_DIRS)/%.o: %
	@test -d $(OUT_DIRS) || mkdir -pm 755 $(OUT_DIRS)
	@test -d $(@D) || mkdir -pm 755 $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean run
clean:
	$(RM) -r $(OUT_DIRS)

run: all
	@echo
	@echo "Press Ctrl-A and then X to exit QEMU"
	@echo
	qemu-system-aarch64 \
		-machine virt -cpu cortex-a53 \
		-smp 4 -m 1024 \
		-nographic -serial mon:stdio \
		-kernel $(IMAGE).img

