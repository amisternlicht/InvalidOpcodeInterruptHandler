#include <asm/desc.h>

void my_store_idt(struct desc_ptr *idtr) {
// <STUDENT FILL> - HINT: USE INLINE ASSEMBLY
__asm__("sidt %0"
    :"=m" (*idtr)                  /*output*/
    :                             /*input*/
    :                             /*clobbered*/
	);
return;
// </STUDENT FILL>
}

void my_load_idt(struct desc_ptr *idtr) {
// <STUDENT FILL> - HINT: USE INLINE ASSEMBLY
__asm__(    
    "lidt %0"
    :                            /*output read*/
    :"m" (*idtr)                /*input read*/
    :                            /*clobbered*/
    );
return;
// <STUDENT FILL>
}

void my_set_gate_offset(gate_desc *gate, unsigned long addr) {
// <STUDENT FILL> - HINT: NO NEED FOR INLINE ASSEMBLY
 unsigned long my_offset_low = addr << 48;
 unsigned long my_offset_middle = addr << 32;
 unsigned long my_offset_high;
 my_offset_low = my_offset_low >> 48;
 my_offset_middle = my_offset_middle >> 48;
 my_offset_high = addr >> 32;
 gate->offset_low = (u16)my_offset_low;
 gate->offset_middle = (u16)my_offset_middle;
 gate->offset_high = (u32)my_offset_high;
// </STUDENT FILL>
}

unsigned long my_get_gate_offset(gate_desc *gate) {
// <STUDENT FILL> - HINT: NO NEED FOR INLINE ASSEMBLY
 unsigned long my_offset_low = (unsigned long)(gate->offset_low);
 unsigned long my_offset_middle = (unsigned long)(gate->offset_middle);
 unsigned long my_offset_high = (unsigned long)(gate->offset_high);
 unsigned long gate_offset = 0;
 gate_offset += my_offset_low; 
 my_offset_middle = my_offset_middle << 16;
 my_offset_high = my_offset_high << 32;
 gate_offset += my_offset_middle;
 gate_offset += my_offset_high;
return gate_offset;
// </STUDENT FILL>
}
