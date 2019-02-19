################################################################################
# Makefile for long double printf test.
# The test demonstrates reduced code size when linked with libc_nano_ld.a library.
# libc_nano_ld.a: This is newlib built with configure option 
# 		--enable-newlib-nano-formatted-io-longdouble.It splits long double printf code from
# 		regular printf code.Application size gets reduced when there are
#		no long double values to print.
################################################################################

RM := rm -rf

RISCV=/home/deepa/work/RISCV/playtoolchain/DeepaAlgoChips/sifive-newlib-task-v2.0/install64
UNPATCH_RISCV=/home/deepa/work/RISCV/unpatch/install64

ifndef QEMU
QEMU = /home/deepa/work/RISCV/playtoolchain/install/bin
endif

# All Target
all: test1 test1-nano test1-nano-u test1-nano-u-u test1-nano-ld test1-nano-ld-u  test2 test2-nano test2-nano-u test2-nano-ld test2-nano-ld-u

#Link application with libformatio.a
test1:
	@echo 'Building target: test1'
	@echo '--------------------------------------------'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test1.c -o test1.elf`
	@echo 'Executing target: test1'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test1.elf | grep "tf"`
	@echo ' '
	@echo ' '
	@echo 'Building target:$@ with UNPATCH tools and library...'
	@echo '--------------------------------------------'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-gcc test1.c -o test1-org.elf`
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 test1-org.elf` 
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-nm test1.elf | grep "tf"`
	@echo 'Finished building: $@'
	@echo ' '
test1-nano:
	@echo 'Building target: $@'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test1.c -specs=nano.specs -o test1-nano.elf`
	@echo 'Finished building target: $@'
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1-nano.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test1-nano.elf | grep "tf"`
	@echo 'Building target: $@ with UNPATCH tools and library...'
	@echo '--------------------------------------------'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-gcc test1.c -specs=nano.specs -o test1-nano-org.elf`
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 test1-nano-org.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1-nano-org.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test1-nano-org.elf | grep "tf"`

	@echo 'Finished building: $@'
	@echo ' '
test1-nano-u:
	@echo 'Building target: $@'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test1.c -g -specs=nano.specs -u_printf_float -o test1-nano-u.elf`
	@echo 'Finished building target: $@'
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1-nano-u.elf"`
	@echo 'TF mode symbols in test1-nano-u.elf'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test1-nano-u.elf | grep "tf"`
	@echo 'Building with original tools and library...'
	@echo '--------------------------------------------'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-gcc test1.c -specs=nano.specs -u_printf_float -o test1-org-nano-u.elf`
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 test1-org-nano-u.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1-org-nano-u.elf"`
	@echo 'TF mode symbols in test1-org-nano-u.elf'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-nm test1-org-nano-u.elf | grep "tf"`
	@echo 'Finished building: $@'
	@echo ' '
test1-nano-u-u:
	@echo 'Building target: $@'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test1.c -g -specs=nano.specs -u_printf_float -u_printf_longdouble -o test1-nano-u-u.elf`
	@echo 'Finished building target: $@'
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1-nano-u-u.elf"`
	@echo 'TF mode symbols in test1-nano-u-u.elf'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test1-nano-u-u.elf | grep "tf"`
	@echo 'Building target: $@ with UNPATCH tools and library...'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-gcc test1.c -g -specs=nano.specs -u_printf_float -u_printf_longdouble -o test1-nano-u-u-org.elf`
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 test1-nano-u-u-org.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1-nano-u-u-org.elf"`
	@echo 'TF mode symbols in test1-nano-u-u-org.elf'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test1-nano-u-u-org.elf | grep "tf"`

test1-nano-ld: 
	@echo 'Building target: $@'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test1.c -specs=nano-ld.specs -o test1-nano-ld.elf`
	@echo 'Finished building target: $@'
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1-nano-ld.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test1-nano-ld.elf | grep "tf"`
	@echo 'Finished building: $@'
	@echo ' '

test1-nano-ld-u: 
	@echo 'Building target: $@'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test1.c -g -specs=nano-ld.specs -u _printf_longdouble -o test1-nano-ld-u.elf`
	@echo 'Finished building target: $@'
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test1-nano-ld-u.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test1-nano-ld-u.elf | grep "tf"`
	@echo 'Finished building: $@'
	@echo ' '

test2:
	@echo 'Building target: test2'
	@echo '--------------------------------------------'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test2.c -o test2.elf`
	@echo 'Executing target: test2'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test2.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test2.elf | grep "tf"`
	@echo 'Building target: $@ with UNPATCH tools and library...'
	@echo '--------------------------------------------'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test2.c -o test2-org.elf`
	@echo 'Executing target: test2-org'
	@echo `$(QEMU)/qemu-riscv64 test2-org.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test2-org.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test2-org.elf | grep "tf"`
	@echo 'Finished building: $@'
	@echo ' '
test2-nano:
	@echo 'Building target: $@'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test2.c -specs=nano.specs -o test2-nano.elf`
	@echo 'Finished building target: $@'
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test2-nano.elf"`
	@echo 'TF mode symbols in test2-nano.elf'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test2-nano.elf | grep "tf"`
	@echo 'Building target: $@ with UNPATCH tools and library...'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-gcc test2.c -specs=nano.specs -o test2-org-nano.elf`
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 test2-org-nano.elf` 
	@echo 'TF mode symbols in test2-org-nano.elf'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-nm test2-org-nano.elf | grep "tf"`
	@echo 'Finished building: $@'
	@echo ' '
test2-nano-u:
	@echo 'Building target: $@'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test2.c -specs=nano.specs -u_printf_float -o test2-nano-u.elf`
	@echo 'Finished building target: $@'
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test2-nano-u.elf"`
	@echo 'TF mode symbols in test2-nano-u.elf'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test2-nano-u.elf | grep "tf"`
	@echo 'Building target: $@ with UNPATCH tools and library...'
	@echo '--------------------------------------------'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-gcc test2.c -specs=nano.specs -u_printf_float -o test2-org-nano-u.elf`
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 test2-org-nano-u.elf` 
	@echo 'TF mode symbols in test2-org-nano-u.elf'
	@echo `$(UNPATCH_RISCV)/bin/riscv64-unknown-elf-nm test2-org-nano-u.elf | grep "tf"`
	@echo 'Finished building: $@'
	@echo ' '
test2-nano-ld: 
	@echo 'Building target: $@'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test2.c -specs=nano-ld.specs -o test2-nano-ld.elf`
	@echo 'Finished building target: $@'
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test2-nano-ld.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test2-nano-ld.elf | grep "tf"`
	@echo 'Finished building: $@'
	@echo ' '

test2-nano-ld-u: 
	@echo 'Building target: $@'
	@echo '--------------------------------------------'
	@echo 'Invoking: GNU RISC-V Cross C Linker'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-gcc test2.c -specs=nano-ld.specs -u_printf_longdouble -o test2-nano-ld-u.elf`
	@echo 'Finished building target: $@'
	@echo 'Executing target: $@'
	@echo `$(QEMU)/qemu-riscv64 $@.elf` 
	@echo 'Invoking: GNU RISC-V Cross Print Size'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-size --format=berkeley "test2-nano-ld-u.elf"`
	@echo 'TF mode symbols in exe'
	@echo `$(RISCV)/bin/riscv64-unknown-elf-nm test2-nano-ld-u.elf | grep "tf"`
	@echo 'Finished building: $@'
	@echo ' '

clean:
	`rm -rf *.elf`
