/* Linker script for Atmel AT91SAM7S devices

   This linker script is intended to place the program
   in FLASH but not interfere with SAM-BA. An AT91SAM7S64
   is assumed hence only 64K of flash.

   Similarly, it assumes only 16K of RAM, with SAM-BA using
   8k at 0x200000.
*/
OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)

MEMORY
{
  stack   : ORIGIN = 0x202000+8k-1k, LENGTH = 1k
  heap    : ORIGIN = 0x202000+8k-1k-4k, LENGTH = 4k
  ram     : ORIGIN = 0x202000, LENGTH = 8k-4k-1k
  flash   : ORIGIN = 0x108000, LENGTH = 64k-32k
}
PROVIDE (__top_of_stack = 0x202000+8k);

SECTIONS
{
  /******************************/
  /*         F L A S H          */
  /******************************/
  .init : { KEEP (*(.init)) } >flash =0
  .text :
  {
    *(.text .stub .text.* .gnu.linkonce.t.*)
    KEEP (*(.text.*personality*))
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
    *(.glue_7t) *(.glue_7)
  } >flash =0
  .fini : { KEEP (*(.fini)) } >flash =0

  .rodata         : { *(.rodata .rodata.* .gnu.linkonce.r.*) } >flash
  .rodata1        : { *(.rodata1) } >flash
  .ARM.extab   : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >flash
   __exidx_start = .;
  .ARM.exidx   : { *(.ARM.exidx* .gnu.linkonce.armexidx.*) } >flash
   __exidx_end = .;
  .eh_frame_hdr : { *(.eh_frame_hdr) } >flash
  .eh_frame       : ONLY_IF_RO { KEEP (*(.eh_frame)) } >flash
  .gcc_except_table   : ONLY_IF_RO { KEEP (*(.gcc_except_table)) *(.gcc_except_table.*) } >flash
  /* Adjust the address for the data segment.  We want to adjust up to
     the same address within the page on the next page up.  */
  . = ALIGN(256) + (. & (256 - 1));
  /* Exception handling  */
  .eh_frame       : ONLY_IF_RW { KEEP (*(.eh_frame)) } >flash
  .gcc_except_table   : ONLY_IF_RW { KEEP (*(.gcc_except_table)) *(.gcc_except_table.*) } >flash
  /* Thread Local Storage sections  */
  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) } >flash
  /* Ensure the __preinit_array_start label is properly aligned.  We
     could instead move the label definition inside the section, but
     the linker would then create the section even if it turns out to
     be empty, which isn't pretty.  */
  . = ALIGN(32 / 8);
  PROVIDE (__preinit_array_start = .);
  .preinit_array     : { KEEP (*(.preinit_array)) } >flash
  PROVIDE (__preinit_array_end = .);
  PROVIDE (__init_array_start = .);
  .init_array     : { KEEP (*(.init_array)) } >flash
  PROVIDE (__init_array_end = .);
  PROVIDE (__fini_array_start = .);
  .fini_array     : { KEEP (*(.fini_array)) } >flash
  PROVIDE (__fini_array_end = .);
  .ctors          :
  {
    /* gcc uses crtbegin.o to find the start of
       the constructors, so we make sure it is
       first.  Because this is a wildcard, it
       doesn't matter if the user does not
       actually link against crtbegin.o; the
       linker won't look for a file to match a
       wildcard.  The wildcard also means that it
       doesn't matter which directory crtbegin.o
       is in.  */
    KEEP (*crtbegin*.o(.ctors))
    /* We don't want to include the .ctor section
       from the crtend.o file until after the sorted ctors.
       The .ctor section from the crtend file contains the
       end of ctors marker and it must be last */
    KEEP (*(EXCLUDE_FILE (*crtend*.o ) .ctors))
    KEEP (*(SORT(.ctors.*)))
    KEEP (*(.ctors))
  } >flash
  .dtors          :
  {
    KEEP (*crtbegin*.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend*.o ) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
  } >flash
  .jcr            : { KEEP (*(.jcr)) } >flash
  .data.rel.ro : { *(.data.rel.ro.local) *(.data.rel.ro*) } >flash
  .dynamic        : { *(.dynamic) } >flash
  .got            : { *(.got.plt) *(.got) } >flash
  . = ALIGN(32 / 8);
  __etext = .;
  PROVIDE (_etext = .);
  PROVIDE (etext = .);

  /******************************/
  /*           R A M            */
  /******************************/
  /* Thread-local storage */
  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) } >ram
  .data : AT (__etext)
  {
    __data_start = . ;
    *(.data .data.* .gnu.linkonce.d.*)
    KEEP (*(.gnu.linkonce.d.*personality*))
    SORT(CONSTRUCTORS)
   /* Align here to ensure that the .data section occupies space up to
      _end.  Align after .data to ensure correct alignment even if the
      .data section disappears because there are no input sections.  */
   . = ALIGN(32 / 8);
  } >ram
  .data1 : AT( LOADADDR(.data) + SIZEOF(.data) ) { 
    *(.data1) 
   . = ALIGN(32 / 8);
  } >ram
  . = ALIGN(32 / 8);

  _edata = .;
  __data_end = .;
  PROVIDE (edata = .);

  /* These are used by crt0.S to copy initial values in the .data
     section to their run-time addresses. */
   __data_load_start = LOADADDR(.data);
   __data_load_end = LOADADDR(.data1) + SIZEOF(.data1);
 
  .bss            :
  {
    __bss_start = .;
    __bss_start__ = .;
   *(.dynbss)
   *(.bss .bss.* .gnu.linkonce.b.*)
   *(COMMON)
    _bss_end__ = . ; __bss_end__ = . ;
  } >ram

  /* end (and its variants) define the beginning of the heap */
  _end = .;
  __end__ = .;
  PROVIDE (end = .);

  /* Stabs debugging sections.  */
  .stab          0 : { *(.stab) }
  .stabstr       0 : { *(.stabstr) }
  .stab.excl     0 : { *(.stab.excl) }
  .stab.exclstr  0 : { *(.stab.exclstr) }
  .stab.index    0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment       0 : { *(.comment) }
  /* DWARF debug sections.
     Symbols in the DWARF debugging sections are relative to the beginning
     of the section so we begin them at 0.  */
  /* DWARF 1 */
  .debug          0 : { *(.debug) }
  .line           0 : { *(.line) }
  /* GNU DWARF 1 extensions */
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  /* DWARF 1.1 and DWARF 2 */
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  /* DWARF 2 */
  .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
  .debug_abbrev   0 : { *(.debug_abbrev) }
  .debug_line     0 : { *(.debug_line) }
  .debug_frame    0 : { *(.debug_frame) }
  .debug_str      0 : { *(.debug_str) }
  .debug_loc      0 : { *(.debug_loc) }
  .debug_macinfo  0 : { *(.debug_macinfo) }
  /* SGI/MIPS DWARF 2 extensions */
  .debug_weaknames 0 : { *(.debug_weaknames) }
  .debug_funcnames 0 : { *(.debug_funcnames) }
  .debug_typenames 0 : { *(.debug_typenames) }
  .debug_varnames  0 : { *(.debug_varnames) }
  .note.gnu.arm.ident 0 : { KEEP (*(.note.gnu.arm.ident)) }
  /DISCARD/ : { *(.note.GNU-stack) }
}
