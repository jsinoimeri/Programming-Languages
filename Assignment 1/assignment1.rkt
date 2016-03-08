#lang racket
; Name: Jeton Sinoimeri
; Assignment 1


; Global Variables
(define stack (list))
(define userInput (list))
(define operands (list "+" "-" "/" "*"))
(define i 0)
(define popOnce #f)
(define opStack (list))
(define correctSyntax 0)
(define regStack (list))
(define regNum 0)
(define i1 0)



; Functions

; Pushing Register values to register stack
(define (pushReg var stack)
  (set! regStack (append (list var) stack))
)

; Pushing Operands to operand stack
(define (pushOp var)
  (set! opStack (append (list var) opStack))
)

; Popping from register stack
(define (popReg stack)
  (define element (car stack))
  (set! regStack (cdr stack))
  element
)

; Popping from operand stack
(define (popOp stack)
  (define element (car stack))
  (set! opStack (cdr stack))
  element
)

; Pushing to stack used in syntax checking
(define (push var)
  (set! stack (append (list var) stack))
)

; Popping from stacked used in sytax checking
(define (pop)
  (define element (car stack))
  (set! stack (cdr stack))
  (set! popOnce #t)
  element
)

; user input
(define (stringTOlist)
  (set! userInput (string-split (read-line)))
)


; Syntax Checker
(define (syntax)
  
  ; check if i is less than the length of userInput
  (cond ((< i (length userInput))
         
         ; get the element at position i
         (define strElement (list-ref userInput i))
         
         ; check if anything but closing bracket
         (cond ((not(equal? ")" strElement))
                ; push the element to the stack
                (push strElement))
               
               ; check if closing bracket
               (else (push strElement)
                     
                     ; check if length of stack is at least 3, if there is a number in first and second position
                     ; if the operand in third position is in the list of operands and the last element is an opening bracket
                      (cond ((and (> (length stack) 3)
                              (number? (string->number(list-ref stack 1 )))
                                 (number? (string->number(list-ref stack 2 )))
                                 (not (eq? #f (member (list-ref stack 3) operands)))
                                 (equal? (list-ref stack 4) "("))
                                  
                                  ; pop 5 times
                                  (pop)                            
                                  (pop)
                                  (pop)
                                  (pop)
                                  (pop)
                                  
                                  ; push a string representation of a number
                                  (push "1"))                      
                            )))
         
         ; increment i
         (set! i (+ i 1))
         
         ; call syntax again
         (syntax)  
         
         )
        
       (else 
        
          ; check if there is only 1 element in stack and its a number and you have popped at least once from stack
          (cond ((and(eq? (length stack) 1) (number? (string->number(list-ref stack 0))) (eq? #t popOnce) ) (set! correctSyntax 1)) 
                
                ; otherwise syntax is incorrect
                (else (display "Syntax Error\n") (set! correctSyntax 0))))) 
)


; interrupts the syntax into machine code                
(define (interrupter)
  
  ; holds the register value used for storing result
  (define regHigher -1)
  
   ; holds the operand
  (define op "")         
  
  
  ; check if i1 is less than length of userInput
  (cond ((< i1 (length userInput))
         
         ; check if that element is a number
         (cond ((number? (string->number(list-ref userInput i1))) 
                
                ; increment register number by one
                (set! regNum (+ regNum 1) )
                
                ; display message
                (display "move value into register-")
                (display regNum)
                (display #\newline)
                
                ; push register number into register stack
                (pushReg regNum regStack))
               
               ; check if the operand is a member in the operands list
               ((not (eq? #f (member (list-ref userInput i1) operands)))
                
                ; push operand to operand stack
                (pushOp (list-ref userInput i1))
               )
               
               ; check if the element is closing bracket
               ((equal? (list-ref userInput i1) ")")
                
                ; get the register value from register stack
                (set! regHigher (popReg regStack))
                
                ; get the operand from operand stack
                (set! op (popOp opStack))
                
                ; check the operand and display apporiate message
                (cond ((equal? op "+") (display "add register-"))
                      ((equal? op "-") (display "substract register-"))
                      ((equal? op "*") (display "multiply register-"))
                      ((equal? op "/") (display "divide register-"))
                )
                
                ; display first register
                (display regHigher)
                
                ; display message
                (display " register-")
                
                ; display second register by popping from register stack
                (display (popReg regStack))
                
                ; display newline
                (display #\newline)
                
                ; push the first register to register stack
                (pushReg regHigher regStack)
               )
        )
         
        ; increment i1
        (set! i1 (+ i1 1))
        
        ; call interrupter
        (interrupter)
  )
        
        ; call reset
        ( else (reset) )
  )
)

; reset all global variables
(define (reset)
  (set! correctSyntax 0)
  (set! regNum 0)
  (set! i1 0)
  (set! i 0)
  (set!  popOnce #f)
  (set! stack (list))
  (set! regStack (list))
  (set! opStack (list))
)


; function to be called
(define (compile)
  
  ; display instructions for user helping
  (display "Enter spaces between every character\n")
  (display "Ex: ( + 2 3 )\n")
  (display "Ex: ( * ( + 2 3 ) 3 )\n")
  (display "Ex: ( / ( + 2 5 ) ( - 4 8 ) )\n\n\n")
  
  ; call stringTOlist
  (stringTOlist)
  
  ; call syntax
  (syntax)
  
  ; call interrupter function if syntax is correct
  (cond ((eq? correctSyntax 1) (interrupter)))
)
  

