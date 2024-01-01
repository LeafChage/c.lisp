(in-package :cl-user)
(defpackage c.code
  (:NICKNAMES :code)
  (:use :cl)
  (:EXPORT #:code-gen))
(in-package :c.code)

(defun show (&rest text)
  (let ((head (car text))
        (tail (cdr text)))
    (if (null tail)
        (format nil "~a" head)
        (format nil "~a~%~a" head (apply #'show tail )))))

(defun puts ()
  '("# void puts(*char, int)"
    "puts:"
    "  push rbp"
    "  mov rbp, rsp"
    ""
    "  mov rcx, [rbp+0x10] # char* str"
    "  mov rdx, [rbp+0x18] # int length"
    "  mov rax, 0x04       # system call: write"
    "  mov rbx, 0x01       # standard io"
    "  int 0x80"
    ""
    "  mov rsp, rbp"
    "  pop rbp"
    "  ret"
    ""))

(defun main (n)
  (list "main:"
    (format nil "  mov rbx, ~a" n)
    "  mov rax, 0x01"
    "  int 0x80"
    ""))

(defun header ()
  '(".intel_syntax noprefix"
    ""
    ".data"
    ""
    ".text"
    ""
    ".globl main"))

(defun code-gen (token)
  (apply #'show (concatenate 'list
                             (header)
                             (main (car token)))))



