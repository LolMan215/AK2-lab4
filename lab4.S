.global lab4
.syntax unified

#define X1 #12
#define X2 #2
#define X3 #-10
#define X4 #15


lab4:
  push {lr}
  bl task1
  bl task2
  pop {pc}

task1:
  push {lr}
  mov r0, X1
  mov r1, #0

  mov r2, X2
  mov r3, #0

  mov r4, X3
  mov r5, #-1

  mov r6, X4
  mov r7, #0

  // Calculation (X3+1-X4)/4∨4(X1/2+X2)
  
  // (X3+1)
  add r4, #1
  adc r5, #0

  // (X3+1-X4)
  sub r4, r6
  sbc r5, r7
  
  // (X3+1-X4)/4
    asr r5, #2
    lsr r4, #2  
    
  // x1/2
    asr r1, #1
    lsr r0, #1
    
  // x1/2+x2
  add r0, r2
  adc r1, r3
  
  //4(X1/2+X2)
    lsl r0, #2
    lsl r1, #2
    
  // (X3+1-X4)/4∨4(X1/2+X2)

  orr r0, r4
  orr r1, r5
  
  bl correction
  pop {pc}
  

// Result correction
correction:
  push {lr}
  bvc step2
  lsr r0, #1
  lsr r1, #1
step2:
  orr r0, #0  // Update flag reg
  bne step4
  orr r1, #0  // Update flag reg
  bne step4
  mov r0, #0b1111110101001
step4:    
  mov r11, #0b1111110101001
  add r1, r11
  and r5, r1, #0xc0000000
  beq step7
  eor r5, #0xc0000000
  beq step7
  lsr r0, #1
  lsr r1, #1
step7:
  bvs end_correction
  push {r0}
  push {r1}
  pop {r1}
  pop {r0}

end_correction:
  pop {pc}

  // task 2
task2:
  push {lr}

  // declaration
  mov r0, #1

program_1:
  // 1. r0 = r0 + 1
  add r0, #1

  // 2. r0 = r0 + 1 
  add r0, #1
 
point1:
  // 3. r0 = r0 + 1 
  add r0, #1

  // 4. jump1
  bvc point2
    
  // 6. r0 = r0 + 1
  add r0, #1

  b point3
  
point2:
  // 5. r0 = r0 + 1
  add r0, #1

  // 7. r0 = r0 + 1
  adds r0, #1
  
point3:
  // 8. jump3  beq | bne for Z
  beq point1
    
    bl program_2 

  // 9. r0 = r0 + 1
  add r0, #1
  pop {pc}

program_2:
  push {lr}
  
point4:
  // 10. r0 = r0 + 1
  adds r0, #1
        
  // 11. jump4 bcs | bcc for C
  bcs point5

  bl program_3

  // 12. r0 = r0 + 1
  add r0, #1
  
point5:
  // 13. jump 5 bvs | bvc for V
  
  bvs point4 
    
  // 14. r0 = r0 + 1
  add r0, #1

  // 15. r0 = r0 + 1
  add r0, #1

  pop {pc}

program_3:
  push {lr}

  // 17. r0 = r0 + 1
  add r0, #1

  // 18. r0 = r0 + 1
  add r0, #1
  pop {pc}
