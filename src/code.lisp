(in-package :cl-user)
(defpackage c.code
  (:NICKNAMES :code)
  (:use :cl
        :alexandria
        :c.parser)
  (:IMPORT-FROM :c.node)
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
    "push rbp"
    "mov rbp, rsp"
    ""
    "mov rcx, [rbp+0x10] # char* str"
    "mov rdx, [rbp+0x18] # int length"
    "mov rax, 0x04       # system call: write"
    "mov rbx, 0x01       # standard io"
    "int 0x80"
    ""
    "mov rsp, rbp"
    "pop rbp"
    "ret"
    ""))

(defmethod code ((n node:[num]))
  (list (format nil "push ~a" (node:value n))))

(defmethod code ((n node:[n<]))
  (list (code (node:left n))
        (code (node:right n))
        (list "pop rdi"
              "pop rax"
              "cmp rax, rdi"
              "setl al"
              "push rax")))

(defmethod code ((n node:[n<=]))
  (list (code (node:left n))
        (code (node:right n))
        (list "pop rdi"
              "pop rax"
              "cmp rax, rdi"
              "setle al"
              "push rax")))

(defmethod code ((n node:[n!=]))
  (list (code (node:left n))
        (code (node:right n))
        (list "pop rdi"
              "pop rax"
              "cmp rax, rdi"
              "setne al"
              "push rax")))

(defmethod code ((n node:[n==]))
  (list (code (node:left n))
        (code (node:right n))
        (list "pop rdi"
              "pop rax"
              "cmp rax, rdi"
              "sete al"
              "push rax")))

(defmethod code ((n node:[n+]))
  (list (code (node:left n))
        (code (node:right n))
        (list "pop rdi"
              "pop rax"
              "add rax, rdi"
              "push rax")))

(defmethod code ((n node:[n-]))
  (list (code (node:left n))
        (code (node:right n))
        (list "pop rdi"
              "pop rax"
              "sub rax, rdi"
              "push rax")))

(defmethod code ((n node:[n*]))
  (list (code (node:left n))
        (code (node:right n))
        (list "pop rdi"
              "pop rax"
              "imul rax, rdi"
              "push rax")))

(defmethod code ((n node:[n/]))
  (list (code (node:left n))
        (code (node:right n))
        (list "pop rdi"
              "pop rax"
              "cqo"
              "idiv rdi"
              "push rax")))

(defun main (token)
  (flatten (list
             "main:"
             (code token)
             "pop rbx"
             "mov rax, 0x01"
             "int 0x80"
             "")))

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
                             (main token))))

