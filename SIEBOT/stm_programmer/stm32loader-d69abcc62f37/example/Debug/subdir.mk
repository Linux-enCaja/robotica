################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
O_SRCS += \
../main.o \
../stm32f10x_gpio.o \
../stm32f10x_rcc.o 

C_SRCS += \
../main.c \
../stm32f10x_adc.c \
../stm32f10x_bkp.c \
../stm32f10x_dma.c \
../stm32f10x_exti.c \
../stm32f10x_gpio.c \
../stm32f10x_i2c.c \
../stm32f10x_it.c \
../stm32f10x_iwdg.c \
../stm32f10x_lib.c \
../stm32f10x_nvic.c \
../stm32f10x_pwr.c \
../stm32f10x_rcc.c \
../stm32f10x_spi.c \
../stm32f10x_systick.c \
../stm32f10x_usart.c \
../stm32f10x_vector.c \
../stm32f10x_wwdg.c 

OBJS += \
./main.o \
./stm32f10x_adc.o \
./stm32f10x_bkp.o \
./stm32f10x_dma.o \
./stm32f10x_exti.o \
./stm32f10x_gpio.o \
./stm32f10x_i2c.o \
./stm32f10x_it.o \
./stm32f10x_iwdg.o \
./stm32f10x_lib.o \
./stm32f10x_nvic.o \
./stm32f10x_pwr.o \
./stm32f10x_rcc.o \
./stm32f10x_spi.o \
./stm32f10x_systick.o \
./stm32f10x_usart.o \
./stm32f10x_vector.o \
./stm32f10x_wwdg.o 

C_DEPS += \
./main.d \
./stm32f10x_adc.d \
./stm32f10x_bkp.d \
./stm32f10x_dma.d \
./stm32f10x_exti.d \
./stm32f10x_gpio.d \
./stm32f10x_i2c.d \
./stm32f10x_it.d \
./stm32f10x_iwdg.d \
./stm32f10x_lib.d \
./stm32f10x_nvic.d \
./stm32f10x_pwr.d \
./stm32f10x_rcc.d \
./stm32f10x_spi.d \
./stm32f10x_systick.d \
./stm32f10x_usart.d \
./stm32f10x_vector.d \
./stm32f10x_wwdg.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cygwin C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


