#!/usr/bin/env python
"""Show things about the microcontroller"""

import os
import sys

import samiam
import sambaif

PeripheralID = {
  0: 'AICFIQ',
  1: 'SYSIRQ',
  2: 'PIOA',
  4: 'ADC',
  5: 'SPI',
  6: 'USART0',
  7: 'USART1',
  8: 'SSC',
  9: 'TWI',
  10:'PWMC',
  11:'UDP',
  12:'TC0',
  13:'TC1',
  14:'TC2',
  30:'AICIRQ0',
  31:'AICIRQ1' }

def info_help(obj):
  print \
"""You can display information about the following systems on the device
by typing 'info system' where 'system' is one of:

power    - power management and clocks
reset    - reset controller
rtt      - real-time timer
pit      - periodic interval timer
wd       - watchdog timer
memory   - memory controller
flash    - flash controller
aic      - advanced interrupt controller
pio      - parallel I/O controller
spi      - SPI controller
twi      - TWI controller
usart    - USART controller
ssc      - Synchronous serial controller
tc       - Timer/counter
pwm      - PWM controller
usb      - USB controller
ad       - A/D converter
dbgu     - debug unit
"""

def info(obj, parm):
  if parm is None:
    info_help(obj)
    return

  parm = parm.lower()
  if parm=='power':
    info_power(obj)    # Done
  elif parm=='reset':
    info_reset(obj)    # Done
  elif parm=='rtt':
    info_rtt(obj)      # Done
  elif parm=='pit':
    info_pit(obj)      # Done
  elif parm=='wd':
    info_wd(obj)       # Done
  elif parm=='memory':
    info_memory(obj)   # Done
  elif parm=='flash':
    info_flash(obj)    # Done
  elif parm=='aic':
    info_aic(obj)      # Done
  elif parm=='pio':
    info_pio(obj)      # Done
  elif parm=='spi':
    info_spi(obj)      # Done
  elif parm=='twi':
    info_twi(obj)
  elif parm=='usart':
    info_usart(obj)
  elif parm=='ssc':
    info_ssc(obj)
  elif parm=='tc':
    info_tc(obj)       # Done
  elif parm=='pwm':
    info_pwm(obj)
  elif parm=='usb':
    info_usb(obj)      # Done
  elif parm=='ad':
    info_ad(obj)
  elif parm=='dbgu':
    info_dbgu(obj)     # Done
  else:
    raise samiam.CommandException, "Unknown 'info' parameter"

def pipe2less():
  if os.isatty(sys.stdout.fileno()):
    return os.popen("less","w")
  else:
    return sys.stdout

def readWord(obj, addr):
  s = sambaif.doReadWord(obj.options, [addr])
  s = s.strip()
  return int(s,16)

def isenabled(val):
  if val:
    return "ENABLED"
  else:
    return "disabled"

def truefalse(val):
  if val:
    return "true"
  else:
    return "false"

def yesno(val):
  if val:
    return "YES"
  else:
    return "no"

def inout(val):
  if val:
    return "IN"
  else:
    return "OUT"

def clock_css(val):  
  if (val & 3)==0:
    clk = "slow clock"
  elif (val & 3)==1:
    clk = "main clock"
  elif (val & 3)==2:
    clk = "ILLEGAL"
  else:
    clk = "PLL clock"

  return clk

def nvprogsize(val):
  val &= 0x0F
  return ["None", "8K", "16K", "32K", "???", "64K", "???", "128K", "???", "256K", "512K", "???", "1024K", "???", "2048K", "???"][val]

def sramsize(val):
  return ["???","1K","2K","???","112K","4K","80K","160K","8K","16K","32K","64K","128K","256K","96K","512K"][val]

def getmck(obj):
  val = readWord(obj, 0xFFFFFC30)  # Read PMC_MCKR
  if (val & 0x3)==0:
    freq = 32.0e3
  elif (val & 0x3)==1:
    freq = 18.432e6
  elif (val & 0x3)==3:
    valpll = readWord(obj, 0xFFFFFC2C)
    plldiv = valpll & 0xFF
    pllmul = ((valpll >> 16) & 0x7FF)
    if plldiv==0 or pllmul==0:
      freq = 0.0
    else:
      freq = (18.432e6/plldiv*(pllmul+1))
  else:
    freq = 0.0

  return freq / (1<<((val>>2) & 0x7)) / 1e6
  
def parity(val):
  if val==0:
    return "Even"
  elif val==1:
    return "Odd"
  elif val==2:
    return "Space"
  elif val==3:
    return "Mark"
  else:
    return "None"

def chanmode(val):
  if val==0:
    return "Normal"
  elif val==1:
    return "Automatic Echo"
  elif val==2:
    return "Local Loopback"
  elif val==3:
    return "Remote Loopback"

def info_power(obj):
  fid = pipe2less()

  val = readWord(obj, 0xFFFFFC08)
  print >> fid, "PMC_SCSR: %08X" % val
  print >> fid, "Processor clock:", isenabled(val & 1), "USB clock:", isenabled(val & 0x80)
  print >> fid, "Programmable clocks:  0:", isenabled(val & 0x100), \
          "  1:", isenabled(val & 0x200), \
          "  2:", isenabled(val & 0x400)

  val = readWord(obj, 0xFFFFFC18)
  print >> fid, "\nPMC_PCSR: %08X" % val
  print >> fid, "Peripheral clocks:"
  count = 0
  for pid in PeripheralID.keys():
    print >> fid, " %7s: %-8s" % (PeripheralID[pid], isenabled(val & (1<<pid))),
    count += 1
    if count==4:
      print >> fid
      count=0
  print >> fid

  val = readWord(obj, 0xFFFFFC20)
  print >> fid, "CKGR_MOR: %08X" % val
  print >> fid, "Main oscillator:", isenabled(val & 1), \
        "  Oscillator bypass:", isenabled(val & 2), \
        "\nOscillator startup:", ((val >> 8) & 0xFF), "slow clock cycles"

  val = readWord(obj, 0xFFFFFC24)
  print >> fid, "\nCKGR_MCFR: %08X" % val
  print >> fid, "Clock cycles in 16 slow clock periods:", val & 0xFFFF
  print >> fid, "   Slow clock is %.3f kHz if main clock is 18.432 MHz" \
      % (16.0/((val&0xFFFF)/18.432e6)/1000)
  print >> fid, "Main clock ready:", truefalse(val & 0x10000)

  val = readWord(obj, 0xFFFFFC2C)
  print >> fid, "\nCKGR_PLLR: %08X" % val
  plldiv = val & 0xFF
  pllmul = ((val >> 16) & 0x7FF)
  pllusb = ((val >> 28) & 0x3)
  print >> fid, "PLL DIV:", plldiv, "  MUL:", pllmul, "USBDIV:", pllusb, \
    "OUT:", ((val >> 14) & 0x3)
  if plldiv==0 or pllmul==0:
    print >> fid, "  PLL is off"
  else:
    pllfreq = (18.432/plldiv*(pllmul+1))
    print >> fid, "  PLL frequency: %.3f MHz (assuming 18.432 MHz oscillator)" \
          % pllfreq
    print >> fid, "  USB frequency: %.3f MHz" % (pllfreq / (1<<pllusb))

  val = readWord(obj, 0xFFFFFC30)
  print >> fid, "\nPMC_MCKR: %08X" % val
  print >> fid, "Master clock: %s   Prescale: divide-by-%d" % \
        (clock_css(val),1<<((val>>2) & 0x7))
  print >> fid, "Device is operating at %.1f MHz" % getmck(obj)        

  val0 = readWord(obj, 0xFFFFFC40)
  val1 = readWord(obj, 0xFFFFFC44)
  val2 = readWord(obj, 0xFFFFFC48)
  print >> fid, "\nPMC_PCK0: %08X  PMC_PCK1: %08X  PMC_PCK2: %08X" % (val0,val1,val2)
  print >> fid, "Programmable clock 0: %s   Prescale: divide-by-%d" % \
        (clock_css(val0),1<<((val0>>2) & 0x7))
  print >> fid, "Programmable clock 1: %s   Prescale: divide-by-%d" % \
        (clock_css(val1),1<<((val1>>2) & 0x7))
  print >> fid, "Programmable clock 2: %s   Prescale: divide-by-%d" % \
        (clock_css(val2),1<<((val2>>2) & 0x7))

  val = readWord(obj, 0xFFFFFC68)
  print >> fid, "\nPMC_SR: %08X" % val
  print >> fid, "Main oscillator stable:", truefalse(val & 1), \
      "  PLL locked:", truefalse(val & 4), \
      "  Master clock ready:", truefalse(val & 8)
  print >> fid, "Programmable clocks ready:  0:", truefalse(val & 0x100), \
      "  1:", truefalse(val & 0x200), \
      "  2:", truefalse(val & 0x400)

  val = readWord(obj, 0xFFFFFC6C)
  print >> fid, "\nPMC_IMR: %08X" % val
  print >> fid, "Interrupts enabled:"
  print >> fid, "  Main oscillator status:", truefalse(val & 1)
  print >> fid, "  PLL lock:", truefalse(val & 4)
  print >> fid, "  Master clock ready:", truefalse(val & 8)
  print >> fid, "  Programmable clock ready:  0:", truefalse(val & 0x100), \
      "  1:", truefalse(val & 0x200), \
      "  2:", truefalse(val & 0x400)
      
def info_reset(obj):
  fid = pipe2less()

  val = readWord(obj, 0xFFFFFD04)
  print >> fid, "RSTC_SR: %08X" % val
  print >> fid, "  Events detected since last RSTC_SR read:"
  print >> fid, "    NRST assert: %s  Brownout: %s" % (yesno(val & 1), yesno(val & 2))
  print >> fid, "  Last reset source:", ["Power up","???","Watchdog","Software","NRST","Brownout","???","???"][(val >> 8)&0x7]
  print >> fid, "  NRST Level: %d  Software Reset In Progress: %s" % (((val >> 16) & 1), yesno((val>>17) & 1))

  val = readWord(obj, 0xFFFFFD08)
  print >> fid, "\nRSTC_MR: %08X" % val
  print >> fid, "  NRST causes User Reset: %s  User Reset causes ARM Reset: %s" % (yesno(val & 1), yesno(val & 0x10))
  print >> fid, "  Brownout causes ARM Reset: %s" % (yesno(val & 0x10000))
  cycles = 2 << ((val >> 8)&0xF)
  dur = 1000.0 * cycles / 32000.0
  print >> fid, "  External reset length: %d slow clock cycles (approximately %.1f ms)" % (cycles, dur)

def info_rtt(obj):
  fid = pipe2less()

  val = readWord(obj, 0xFFFFFD20)
  print >> fid, "RTT_MR: %08X" % val
  print >> fid, "  RTT Prescaler: %d" % ((val & 0xFFFF) or 65536)   # prescale of 0 means 2^16
  print >> fid, "  Alarm Interrupt: %s  RTT Increment Interrupt: %s" % (isenabled((val >> 16)&1), isenabled((val >> 17)&1))
  val = readWord(obj, 0xFFFFFD24)
  print >> fid, "\nRTT_AR: %08X" % val
  val = readWord(obj, 0xFFFFFD28)
  print >> fid, "\nRTT_VR: %08X" % val
  val = readWord(obj, 0xFFFFFD2C)
  print >> fid, "\nRTT_SR: %08X" % val
  print >> fid, "  Alarm Occurred: %s  RTT Increment Occurred: %s" % (yesno(val & 1), yesno(val & 2))

def info_pit(obj):
  fid = pipe2less()

  val = readWord(obj, 0xFFFFFD30)
  print >> fid, "PIT_MR: %08X" % val
  period = 16e-3/getmck(obj)*((val & 0xFFFFF)+1)
  print >> fid, "  Counter period: %d (%.1f ms)" % ((val & 0xFFFFF)+1, period)
  print >> fid, "  Timer Enabled: %s  Timer Interrupt Enabled: %s" % (yesno((val>>24)&1), yesno((val>>25)&1))

  val = readWord(obj, 0xFFFFFD34)
  print >> fid, "\nPIT_SR: %08X" % val
  print >> fid, "  PIV Reached: %s" % yesno(val & 1)

  val = readWord(obj, 0xFFFFFD3C)
  print >> fid, "\nPIT_PIIR: %08X" % val
  print >> fid, "  Counter value: %d  Interval Count: %d" % ((val & 0xFFFFF), ((val >> 20) & 0xFFF))

def info_wd(obj):
  fid = pipe2less()

  val = readWord(obj, 0xFFFFFD44)
  print >> fid, "WD_MR: %08X" % val
  print >> fid, "  Watchdog value: %d  Delta value: %d" % ((val & 0xFFF), ((val >> 16) & 0xFFF))
  print >> fid, "  Watchdog enabled: %s  Interrupt: %s  Reset: %s" % (yesno(not ((val >> 15)&1)), (val>>12)&1, (val>>13)&1)
  print >> fid, "  Watchdog fault activates:",
  if (val >> 14) & 1:
    print >> fid, "processor reset only"
  else:
    print >> fid, "all resets"
  print >> fid, "  Watchdog stops in debug: %s  Watchdog stops in idle: %s" % (yesno((val >> 28)&1), yesno((val >> 29)&1))

  val = readWord(obj, 0xFFFFFD48)
  print >> fid, "\nWD_SR: %08X" % val
  print >> fid, "  Watchdog underflow occurred: %s  Watchdog error occurred: %s" % (yesno(val & 1), yesno(val & 2))

def info_memory(obj):
  fid = pipe2less()

  val = readWord(obj, 0xFFFFFF04)
  print >> fid, "MC_ASR: %08X" % val
  print >> fid, "  Abort due to:"
  print >> fid, "    Undefined address: %-3s  Address misalignment: %s" % (yesno(val & 1), yesno(val & 2))
  print >> fid, "    DMA Controller: %-3s     ARM7TDMI Core: %s" % (yesno(val & 0x10000), yesno(val & 0x20000))
  print >> fid, "  Abort Size: %s" % (["Byte","Half-Word","Word","???"][(val >> 8)&0x3]),
  print >> fid, "  Abort Type: %s" % (["Data Read","Data Write","Code Fetch","???"][(val >> 10)&0x3])
  print >> fid, "  Saved DMA Abort: %s  Saved ARM7TDMI Core Abort: %s" % (yesno((val>>24)&1), yesno((val>>25)&1))

  val = readWord(obj, 0xFFFFFF08)
  print >> fid, "\nMC_AASR: %08X" % val

def info_flash(obj):
  fid = pipe2less()

  val = readWord(obj, 0xFFFFFF60)
  print >> fid, "MC_FMR: %08X" % val
  print >> fid, " Erase before program:", truefalse(not (val & 0x80)), \
      " FLASH wait states:  read:", ((val >> 8) & 0x3)+1, " write:", \
      min(((val >> 8) & 0x3)+2,4)
  print >> fid, " FLASH microsecond cycle number:", ((val >> 16) & 0xFF)      
  print >> fid, " Interrupts enabled:"
  print >> fid, "   Ready:", truefalse(val & 1), \
      " Lock error:", truefalse(val & 4), \
      " Program error:", truefalse(val & 8)

  val = readWord(obj, 0xFFFFFF68)
  print >> fid, "\nMC_FSR: %08X" % val
  print >> fid, " FLASH ready:", truefalse(val & 1), " Security bit active:", \
      truefalse(val & 0x10)
  print >> fid, " Lock error:", truefalse(val & 4), " Programming error:", \
      truefalse(val & 0x08)
  print >> fid, " GPNVM0:", ((val >> 8) & 1), " GPNVM1:", ((val >> 9) & 1)
  print >> fid, " Region locks:"
  for region in range(16):
    print >> fid, " %X:%d" % (region, (val >> (region+16))&1),
  print >> fid

def info_aic(obj):
  fid = pipe2less()

  pids = PeripheralID.keys()
  pids.sort()

  for pid in pids:
    addr = 0xFFFFF000 + pid*4
    val = readWord(obj, addr)
    if PeripheralID[pid][:3]!='AIC':
      # External interrupt source
      print >> fid, '  %7s: %08x: Type: %-23s  Priority: %d' % \
        (PeripheralID[pid], val, ["High-Level Sensitive","Positive-Edge Triggered"][(val>>5)&1], (val&0x7))
    else:
      # Internal interrupt source
      print >> fid, '  %7s: %08x: Type: %-23s  Priority: %d' % \
        (PeripheralID[pid], val, \
        ["Low-Level Sensitive","Negative-Edge Triggered","High-Level Sensitive","Positive-Edge Triggered"][(val>>5)&3], (val&0x7))

    print >> fid, '           Vector: %08X' % readWord(obj, addr+0x80)

  # Do not read AIC_IVR and AIC_FVR as these actually "service" an interrupt
  # from the point of view of the AIC.
  #val = readWord(obj, 0xFFFFF000+0x100)
  #print >> fid, "\nAIC_IVR: %08X" % val
  #val = readWord(obj, 0xFFFFF000+0x104)
  #print >> fid, "\nAIC_FVR: %08X" % val

  val = readWord(obj, 0xFFFFF000+0x108)
  print >> fid, "\nAIC_ISR: %08X" % val
  print >> fid, "  Current interrupt: %d" % (val & 0x1F)

  val = readWord(obj, 0xFFFFF000+0x10C)
  print >> fid, "\nAIC_IPR: %08X" % val
  print >> fid, "  Pending interrupts:"
  count = 0
  for pid in pids:
    print >> fid, "  %7s: %3s" % (PeripheralID[pid], yesno(val & (1<<pid))),
    count += 1
    if count==4:
      print >> fid
      count=0

  val = readWord(obj, 0xFFFFF000+0x110)
  print >> fid, "\nAIC_IMR: %08X" % val
  print >> fid, "  Enabled interrupts:"
  count = 0
  for pid in pids:
    print >> fid, "  %7s: %3s" % (PeripheralID[pid], yesno(val & (1<<pid))),
    count += 1
    if count==4:
      print >> fid
      count=0

  val = readWord(obj, 0xFFFFF000+0x114)
  print >> fid, "\nAIC_CISR: %08X" % val
  print >> fid, "  FIQ line active: %s   IRQ line active: %s" % (truefalse(val & 1), truefalse(val & 2))

  val = readWord(obj, 0xFFFFF000+0x134)
  print >> fid, "\nAIC_SPU: %08X" % val

  val = readWord(obj, 0xFFFFF000+0x138)
  print >> fid, "\nAIC_DCR: %08X" % val
  print >> fid, "  Protection mode: %s  IRQ/FIQ State:" % isenabled(val & 1),
  if (val & 2):
    print >> fid, "forced inactive"
  else:
    print >> fid, "normal"

  val = readWord(obj, 0xFFFFF000+0x148)
  print >> fid, "\nAIC_FFSR: %08X" % val
  print >> fid, "  Fast forcing:"
  count = 0
  for pid in pids:
    print >> fid, "  %7s: %3s" % (PeripheralID[pid], yesno(val & (1<<pid))),
    count += 1
    if count==4:
      print >> fid
      count=0

def info_pio(obj):
  def printiolines(fid, val, dispfunc=yesno):
    for line in range(32):
      if (line&0x7)==0:
        print >> fid, "   ",
      print >> fid, "%2d: %-3s" % (line, dispfunc((val >> line) & 1)),
      if (line&0x7)==7:
        print >> fid

  def printperiph(fid, val, ctrl):
    for line in range(32):
      if (line&0x7)==0:
        print >> fid, "   ",
      ctl_bit = (ctrl>>line)&1
      val_bit = (val>>line)&1
      print >> fid, "%2d: %-3s" % (line, ["A", "B", "PIO", "PIO"][ctl_bit*2|val_bit]),
      if (line&0x7)==7:
        print >> fid

  fid = pipe2less()

  val = readWord(obj, 0xFFFFF400+0x0008)
  print >> fid, "PIO_PSR: %08X" % val
  print >> fid, "  PIO controls:"
  printiolines(fid, val)
  val_pio_ctrl = val

  val = readWord(obj, 0xFFFFF400+0x0018)
  print >> fid, "\nPIO_OSR: %08X" % val
  print >> fid, "  Output enabled:"
  printiolines(fid, val)

  val = readWord(obj, 0xFFFFF400+0x0028)
  print >> fid, "\nPIO_IFSR: %08X" % val
  print >> fid, "  Glitch filter enabled:"
  printiolines(fid, val)

  val = readWord(obj, 0xFFFFF400+0x0038)
  print >> fid, "\nPIO_ODSR: %08X" % val
  print >> fid, "  Output state:"
  printiolines(fid, val, str)

  val = readWord(obj, 0xFFFFF400+0x003C)
  print >> fid, "\nPIO_PDSR: %08X" % val
  print >> fid, "  Actual pin state:"
  printiolines(fid, val, str)

  val = readWord(obj, 0xFFFFF400+0x0048)
  print >> fid, "\nPIO_IMR: %08X" % val
  print >> fid, "  Input change interrupt enabled:"
  printiolines(fid, val)

  val = readWord(obj, 0xFFFFF400+0x004C)
  print >> fid, "\nPIO_ISR: %08X" % val
  print >> fid, "  Input change interrupt detected:"
  printiolines(fid, val)

  val = readWord(obj, 0xFFFFF400+0x0058)
  print >> fid, "\nPIO_MDSR: %08X" % val
  print >> fid, "  Pin is open-drain only:"
  printiolines(fid, val)

  val = readWord(obj, 0xFFFFF400+0x0068)
  print >> fid, "\nPIO_PUSR: %08X" % val
  print >> fid, "  Pull-up resistor is DISABLED:"
  printiolines(fid, val)

  val = readWord(obj, 0xFFFFF400+0x0078)
  print >> fid, "\nPIO_ABSR: %08X" % val
  print >> fid, "  Peripheral selected:"
  printperiph(fid, val, val_pio_ctrl)

  val = readWord(obj, 0xFFFFF400+0x00A8)
  print >> fid, "\nPIO_OWSR: %08X" % val
  print >> fid, "  PIO_ODSR controls line:"
  printiolines(fid, val)

def info_spi(obj):
  def tobin(val, numbits):
    s = ""
    for bit in range(numbits):
      if val & (1<<bit):
        s = '1'+s
      else:
        s = '0'+s
    return s

  fid = pipe2less()

  mck = getmck(obj)

  val = readWord(obj, 0xFFFE0000+0x04)
  print >> fid, "SPI_MR: %08X" % val
  print >> fid, "  Mode: %s  Peripheral Select: %s  Chip Select Decoder: %s" % \
       (["Slave","Master"][val&1], ["Fixed","Variable"][val&2], yesno(val&4))
  print >> fid, "  Mode Fault Detection: %s  Local Loopback path: %s" % \
       (isenabled(val & 0x10), isenabled(val & 0x80))
  dlybcs = max((val >> 24) & 0xFF, 6)
  print >> fid, "  Delay between chip selects: %.1f ns" % (1000.0*dlybcs/mck)
  print >> fid, "  NPCS[3:0] = ",
  pcs = (val>>16)&0xF
  if (val & 4):
    print >> fid, tobin(pcs, 4)
  else:
    if not (pcs&1):
      print >> fid, "1110"
    elif not (pcs&2):
      print >> fid, "1101"
    elif not (pcs&4):
      print >> fid, "1011"
    elif not (pcs&8):
      print >> fid, "0111"
    else:
      print >> fid, "forbidden"

  val = readWord(obj, 0xFFFE0000+0x10)
  print >> fid, "\nSPI_SR: %08X" % val
  print >> fid, "  SPI enabled: %s" % yesno(val&0x10000)
  print >> fid, "  Receive data register full: %s  Transmit data register empty: %s" % (yesno(val&1), yesno(val&2))
  print >> fid, "  Mode fault occurred: %s  Overrun occurred: %s" % (yesno(val&4), yesno(val&8))
  print >> fid, "  End of RX buffer: %s  End of TX buffer: %s" % (yesno(val&0x10), yesno(val&0x20))
  print >> fid, "  RX buffer full: %s  TX buffer full: %s" % (yesno(val&0x40), yesno(val&0x80))
  print >> fid, "  NSS rising edge occurred: %s  Transmission registers empty: %s" % (yesno(val&0x100), yesno(val&0x200))

  val = readWord(obj, 0xFFFE0000+0x1C)
  print >> fid, "\nSPI_IMR: %08X" % val
  print >> fid, "  Interrupts enabled:"
  print >> fid, "     RDRF: %-3s   TDRE: %-3s    MODF: %-3s   OVRES: %-3s" % \
    (yesno(val&1), yesno(val&2), yesno(val&4), yesno(val&8))
  print >> fid, "    ENDRX: %-3s  ENDTX: %-3s  RXBUFF: %-3s  TXBUFE: %-3s" % \
    (yesno(val&0x10), yesno(val&0x20), yesno(val&0x40), yesno(val&0x80))
  print >> fid, "     NSSR: %-3s  TXEMPTY: %-3s" % (yesno(val&0x100), yesno(val&0x200))

  for chan in range(4):
    val = readWord(obj, 0xFFFE0000+0x30+chan*4)
    print >> fid, "\nSPI_CSR%d: %08X" % (chan,val)
    databits = (val >> 4) & 0xF
    if databits > 16:
      databits = "illegal"
    else:
      databits = str(databits+8)
    print >> fid, "  Channel %d: CPOL: %d  NCPHA: %d  Data bits: %s  CS active after transfer: %s" % \
          (chan, (val&1), ((val>>1)&1), databits, yesno(val&8))
    scbr = (val>>8)&0xFF
    dlybs = (val>>16)&0xFF
    dlybct = (val>>24)&0xFF
    if scbr==0:
      scbr = "illegal"
      dlybs = "???"
      dlybct = "???"
    else:
      bps = 1.0e6*mck/scbr
      scbr = "%.1f kbps" % (bps/1e3)
      if dlybs==0:
        dlybs="%.1f us" % (1e6/(2*bps))
      else:
        dlybs="%.1f us" % (dlybs/mck)
      if dlybct==0:
        dlybct="0"
      else:
        dlybct = "%.1f us" % (((32*dlybct)+( ((val>>8)&0xFF)/2.0))/mck)
    print >> fid, "  Baud rate: %s  SPCK Delay: %s  Inter-Transfer Delay: %s" % (scbr, dlybs, dlybct)

def info_twi(obj):
  fid = pipe2less()

  mck = getmck(obj)

  val = readWord(obj, 0xFFFB8000+0x08)
  print >> fid, "TWI_MMR: %08X" % val
  print >> fid, "  Internal Device Address Size:", \
      ["none (byte command protocol)", "one byte", "two bytes", "three bytes"][(val >> 8)&0x3]
  print >> fid, "  Master Read Direction:", ["master write", "master read"][(val >> 12) & 1]
  print >> fid, "  Device Address: 0x%02X" % ((val >> 16) & 0x7F)

  val = readWord(obj, 0xFFFB8000+0x0C)
  print >> fid, "\nTWI_IADR: %08X" % val

  val = readWord(obj, 0xFFFB8000+0x10)
  print >> fid, "\nTWI_CWGR: %08X" % val
  ckdiv = (val >> 16) & 0x7
  chdiv = (val >> 8) & 0xFF
  cldiv = val & 0xFF
  Tlow = (cldiv*(1<<ckdiv) + 3)/mck
  Thigh = (chdiv*(1<<ckdiv) + 3)/mck
  print >> fid, "  Clock Frequency: %.1f kHz  High Period: %.1f us  Low Period: %.1f us" % \
    (1e3/(Tlow+Thigh), Tlow, Thigh)

  val = readWord(obj, 0xFFFB8000+0x20)
  print >> fid, "\nTWI_SR: %08X" % val
  print >> fid, "  Transmit Complete: %s  RHR Ready: %s  THR Ready: %s" % \
      (yesno(val & 1), yesno(val & 2), yesno(val & 4))
  print >> fid, "  Receive Overrun: %s  Transmit Underrun: %s  NACK: %s" % \
      (yesno(val & 0x40), yesno(val & 0x80), yesno(val & 0x100))

  val = readWord(obj, 0xFFFB8000+0x2C)
  print >> fid, "\nTWI_IMR: %08X" % val
  print >> fid, "  Interrupts Enabled:"
  print >> fid, "    Transmit Complete: %s  RHR Ready: %s  THR Ready: %s" % \
      (yesno(val & 1), yesno(val & 2), yesno(val & 4))
  print >> fid, "    Receive Overrun: %s  Transmit Underrun: %s  NACK: %s" % \
      (yesno(val & 0x40), yesno(val & 0x80), yesno(val & 0x100))

def info_usart(obj):
  print 'Not yet implemented.'

def info_ssc(obj):
  print 'Not yet implemented.'

def info_tc(obj):
  edgestr = ["none","rising","falling","any"]
  comparestr = ["none","set","clear","toggle"]
  fid = pipe2less()

  mck = getmck(obj)

  val = readWord(obj, 0xFFFA0000+0xC4)
  print >> fid, "TC_BMR: %08X" % val
  print >> fid, "  XC0: %s  XC1: %s  XC2: %s" % \
    (["TCLK0","none","TIOA1","TIOA2"][val & 0x3], ["TCLK1","none","TIOA0","TIOA2"][(val >> 2) & 0x3], \
     ["TCLK2","none","TIOA0","TIOA1"][(val >> 4) & 0x3])
  for chan in range(3):
    print >> fid, "\nChannel %d:" % chan
    val = readWord(obj, 0xFFFA0000+0x04+chan*0x40)
    print >> fid, "  TC_CMR%d: %08X" % (chan, val)
    print >> fid, "    Clock: %s  Clock Edge: %s  Burst Signal: %s" % \
      (["TIMER_CLOCK1","TIMER_CLOCK2","TIMER_CLOCK3","TIMER_CLOCK4","TIMER_CLOCK5","XC0","XC1","XC2"][val & 0x7],
       ["rising","falling"][(val >> 3)&1],
       ["none","XC0","XC1","XC2"][(val >> 4)&0x3])
    if ((val >> 15) & 0x1):
      # Wave mode
      print >> fid, "    Clock Stop on RC Compare: %s  Clock Disable on RC Compare: %s" % (yesno((val >> 6)&1), yesno((val >> 7)&1))
      print >> fid, "    External Event Edge: %s  External Event: %s  TIOB is: %s" % \
        (edgestr[(val >> 8)&0x3], ["TIOB","XC0","XC1","XC2"][(val >> 10)&0x3], \
         ["input","output"][((val >> 10)&0x3) != 0])
      print >> fid, "    External Event Trigger: %s" % (["no effect","counter reset/counter clock start"][(val >> 12)&1])
      print >> fid, "    Waveform Selection: %s" % \
        (["UP mode","UP mode/automatic trigger on RC compare","UPDOWN mode","UPDOWN mode/automatic trigger on RC compare"][(val >> 13)&3])
      print >> fid, "    RA Compare Effect on TIOA: %s  RC Compare Effect on TIOA: %s" % \
        (comparestr[(val >> 16)&0x3], comparestr[(val >> 18)&0x3])
      print >> fid, "    External Event Effect on TIOA: %s  Software Trigger Effect on TIOA: %s" % \
        (comparestr[(val >> 20)&0x3], comparestr[(val >> 22)&0x3])
      print >> fid, "    RB Compare Effect on TIOB: %s  RC Compare Effect on TIOB: %s" % \
        (comparestr[(val >> 24)&0x3], comparestr[(val >> 26)&0x3])
      print >> fid, "    External Event Effect on TIOB: %s  Software Trigger Effect on TIOB: %s" % \
        (comparestr[(val >> 28)&0x3], comparestr[(val >> 30)&0x3])
    else:
      # Capture mode
      print >> fid, "    Clock Stop on RB Load: %s  Clock Disable on RB Load: %s" % (yesno((val >> 6)&1), yesno((val >> 7)&1))
      print >> fid, "    External Trigger Edge: %s  External Trigger: %s" % \
          (edgestr[(val >> 8) & 0x3],
           ["TIOB","TIOA"][(val >> 10) & 1])
      print >> fid, "    RC Compare Trigger: %s" % (["no effect","counter reset/counter clock start"][(val >> 14)&1])
      print >> fid, "    RA Loads on TIOA edge: %s  RB Loads on TIOA edge: %s" % \
          (edgestr[(val >> 16)&0x3], edgestr[(val >> 18)&0x3])

    val = readWord(obj, 0xFFFA0000+0x20+chan*0x40)
    print >> fid, "  TC_SR%d: %08X" % (chan, val)
    print >> fid, "    Counter Overflow: %s  Load Overrun: %s" % (yesno(val & 1), yesno(val & 2))
    print >> fid, "    RA Compare: %s  RB Compare: %s  RC Compare: %s" % (yesno(val&4), yesno(val&8), yesno(val & 0x10))
    print >> fid, "    RA Load: %s  RB Load: %s  EXT Trigger: %s  Clock: %s" % \
        (yesno(val & 0x20), yesno(val & 0x40), yesno(val & 0x80), isenabled(val & 0x10000))
    print >> fid, "    TIOA: %d  TIOB: %d" % ((val >> 17)&1, (val >> 18)&1)

    val = readWord(obj, 0xFFFA0000+0x2C+chan*0x40)
    print >> fid, "  TC_IMR%d: %08X" % (chan, val)
    print >> fid, "    Interrupts enabled:"
    print >> fid, "      Counter Overflow: %s  Load Overrun: %s" % (yesno(val & 1), yesno(val & 2))
    print >> fid, "      RA Compare: %s  RB Compare: %s  RC Compare: %s" % (yesno(val&4), yesno(val&8), yesno(val & 0x10))
    print >> fid, "      RA Load: %s  RB Load: %s  EXT Trigger: %s" % \
        (yesno(val & 0x20), yesno(val & 0x40), yesno(val & 0x80))

    val = readWord(obj, 0xFFFA0000+0x10+chan*0x40)
    print >> fid, "  TC_CV%d: %08X" % (chan, val)
    val = readWord(obj, 0xFFFA0000+0x14+chan*0x40)
    print >> fid, "  TC_RA%d: %08X" % (chan, val)
    val = readWord(obj, 0xFFFA0000+0x18+chan*0x40)
    print >> fid, "  TC_RB%d: %08X" % (chan, val)
    val = readWord(obj, 0xFFFA0000+0x1C+chan*0x40)
    print >> fid, "  TC_RC%d: %08X" % (chan, val)

def info_pwm(obj):
  print 'Not yet implemented.'

def info_usb(obj):
  # Ensure USB peripheral clock is enabled (peripheral ID 11)
  val = readWord(obj, 0xFFFFFC18)
  if not (val & (1 << 11)):
    raise samiam.CommandException, "The USB peripheral clock in the PMC_PCSR must first be enabled."

  fid = pipe2less()
  val = readWord(obj, 0xFFFB0004)
  print >> fid, "UDP_GLB_STAT: %08X" % val
  print >> fid, "Device in address state:", truefalse(val & 1)
  print >> fid, "Device configured:", truefalse(val & 2)
  print >> fid, "Send resume enabled:", truefalse(val & 4)
  print >> fid, "Resume sent to host:", truefalse(val & 8)
  print >> fid, "Remote wake-up enable:", truefalse(val & 16)

  val = readWord(obj, 0xFFFB0008)
  print >> fid, "\nUDP_FADDR: %08X" % val
  print >> fid, "Function address: %d  Function enabled: %s" % \
      (val & 0x7F, truefalse(val & 0x100))

  val = readWord(obj, 0xFFFB0018)
  print >> fid, "\nUDP_IMR: %08X" % val
  print >> fid, "Interrupts enabled:"
  print >> fid, "  Endpoint 0:", truefalse(val & 1), \
                "  Endpoint 1:", truefalse(val & 2), \
                "  Endpoint 2:", truefalse(val & 4), \
                "  Endpoint 3:", truefalse(val & 8)
  print >> fid, "  Suspend:", truefalse(val & 0x100), \
                "  Resume:", truefalse(val & 0x200), \
                "  External resume:", truefalse(val & 0x400), \
                "  Start-of-frame:", truefalse(val & 0x800)
  print >> fid, "  Bus wakeup:", truefalse(val & 0x2000)

  for ep in range(4):
    val = readWord(obj, 0xFFFB0030 + 4*ep)
    print >> fid, "\nEndpoint %d (UDP_CSR%d: %08X)" % (ep, ep, val)
    eptype = ((val >> 8) & 0x7)
    print >> fid, " Enabled:", truefalse(val & 0x8000), " Endpoint type:",
    if eptype==0:
      print >> fid, "control"
    elif eptype==1:
      print >> fid, "isochronous OUT"
    elif eptype==5:
      print >> fid, "isochronous IN"
    elif eptype==2:
      print >> fid, "bulk OUT"
    elif eptype==6:
      print >> fid, "bulk IN"
    elif eptype==3:
      print >> fid, "interrupt OUT"
    elif eptype==7:
      print >> fid, "interrupt IN"
    else:
      print >> fid, "???"
    print >> fid, " Data IN ACK:", truefalse(val & 1), \
        " Data in bank 0:", truefalse(val & 2), \
        " Data in bank 1:", truefalse(val & 0x40)
    print >> fid, " Received data count:", ((val >> 16) & 0x7FF)        
    if (eptype==0):
      print >> fid, " Setup packet available:", truefalse(val & 4), \
          " Stall acknowledged:", truefalse(val & 8)
    elif eptype in (2,3,6,7):
      print >> fid, " Stall acknowledged:", truefalse(val & 8)
    else:
      print >> fid, " CRC error:", truefalse(val & 8)
    print >> fid, " Transmitter ready:", truefalse(val & 0x10)
    if eptype==0:
        print >> fid, " Transfer direction:", inout(val & 80)

  val = readWord(obj, 0xFFFB0074)
  print >> fid, "\nUDP_TXVC: %08X" % val
  print >> fid, "Transceiver disabled:", truefalse(val & 0x100)

def info_ad(obj):
  print 'Not yet implemented.'

def info_dbgu(obj):
  fid = pipe2less()
  val = readWord(obj, 0xFFFFF200+0x0004)
  print >> fid, 'DBGU_MR: %08X' % val
  print >> fid,'  Parity: %s  Channel mode: %s' % (parity((val >> 9) & 0x7), chanmode((val >> 14) & 0x3))

  val = readWord(obj, 0xFFFFF200+0x0010)
  print >> fid, '\nDBGU_IMR: %08X' % val
  print >> fid,'  Enabled interrupts:'
  print >> fid,'     RXRDY: %-6s  TXRDY: %-6s  ENDRX: %-6s   ENDTX: %-6s' % \
          (isenabled(val & 1), isenabled(val & 2), isenabled(val & 8), isenabled(val & 0x10))
  print >> fid,'      OVRE: %-6s  FRAME: %-6s   PARE: %-6s TXEMPTY: %-6s' % \
          (isenabled(val & 0x20), isenabled(val & 0x40), isenabled(val & 0x80), isenabled(val & 0x200))
  print >> fid,'    TXBUFE: %-6s RXBUFF: %-6s COMMTX: %-6s  COMMRX: %-6s' % \
          (isenabled(val & 0x800), isenabled(val & 0x1000), isenabled((val >> 30) & 1), isenabled((val >> 31) & 1))

  val = readWord(obj, 0xFFFFF200+0x0014)
  print >> fid, '\nDBGU_SR: %08X' % val
  print >> fid,'  Status bits set:'
  print >> fid,'     RXRDY: %-5s  TXRDY: %-5s  ENDRX: %-5s   ENDTX: %-5s' % \
          (truefalse(val & 1), truefalse(val & 2), truefalse(val & 8), truefalse(val & 0x10))
  print >> fid,'      OVRE: %-5s  FRAME: %-5s   PARE: %-5s TXEMPTY: %-5s' % \
          (truefalse(val & 0x20), truefalse(val & 0x40), truefalse(val & 0x80), truefalse(val & 0x200))
  print >> fid,'    TXBUFE: %-5s RXBUFF: %-5s COMMTX: %-5s  COMMRX: %-5s' % \
          (truefalse(val & 0x800), truefalse(val & 0x1000), truefalse((val >> 30) & 1), truefalse((val >> 31) & 1))

  val = readWord(obj, 0xFFFFF200+0x0020)
  print >> fid, '\nDBGU_BRGR: %08X' % val
  if (val & 0xFFFF) == 0:
    brck = 0.0
  elif (val & 0xFFFF) == 1:
    brck = getmck(obj)
  else:
    brck = getmck(obj) / 16.0 / (val & 0xFFFF)
  print >> fid, '  Baud rate clock: %.1f bps (assuming 18.432 MHz oscillator)' % (brck*1e6)

  val = readWord(obj, 0xFFFFF200+0x0040)
  print >> fid, '\nDBGU_CIDR: %08X' % val
  print >> fid, '  Processor: %s  Version: %d  Non-volatile program memory: %s' \
      % (["???", "ARM946E-S","ARM7TDMI","???","ARM920T","ARM926EJ-S","???","???"][(val>>5)&0x7], (val & 0x1F), nvprogsize(val>>8))
  try:
    arch = { 0xF0: 'AT75CXX', 0x40: 'AT91x40', 0x63: 'AT91x63', 0x55: 'AT91x55', 0x42: 'AT91x42', \
             0x92: 'AT91x92', 0x34: 'AT91x34', 0x60: 'AT91SAM7A', 0x70: 'AT91SAM7S', 0x71: 'AT91SAM7XC', \
             0x72: 'AT91SAM7SE', 0x73: 'AT91SAM7L', 0x75: 'AT91SAM7X', 0x19: 'AT91SAM9' }[(val >> 20) & 0xFF]
  except:
    arch = "???"
  print >> fid, '  Second NV program memory: %s  SRAM size: %s  Architecture: %s' \
      % (nvprogsize(val >> 12), \
        sramsize((val >> 16) & 0xF), arch)
  print >> fid, '  NV program type: %s  DBUG_EXID register: %s' \
      % (["ROM","ROMless/on-chip FLASH","Embedded FLASH","ROM=NVPSIZ1/FLASH=NVPSIZ2","SRAM emulating ROM","???","???","???"][(val>>28)&7], truefalse((val >> 31) & 0x1))

  val = readWord(obj, 0xFFFFF200+0x0044)
  print >> fid, '\nDBGU_EXID: %08X' % val

  val = readWord(obj, 0xFFFFF200+0x0048)
  print >> fid, '\nDBGU_FNR: %08X' % val
  print >> fid, "  NTRST of the TAP controller is",
  if (val & 0x1):
    print >> fid, "held low"
  else:
    print >> fid, "driven by the ice_nreset signal"
