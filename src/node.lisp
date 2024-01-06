(in-package :cl-user)
(defpackage c.node
  (:NICKNAMES node)
  (:use :cl)
  (:EXPORT #:kind #:value #:left #:right
           #:is-addressable
           :[num]  #:num
           :[ident] #:ident
           :[n+]   #:n+  #:rn+
           :[n-]   #:n-  #:rn-
           :[n/]   #:n/  #:rn/
           :[n*]   #:n*  #:rn*
           :[n==]  #:n== #:rn==
           :[n!=]  #:n!= #:rn!=
           :[n<]   #:n<  #:rn<
           :[n<=]  #:n<= #:rn<=
           :[n=]  #:n= #:rn=))
(in-package :c.node)

(defclass branch ()
  ((kind :INITARG :kind :READER kind)
   (value :INITARG :value :READER value)))

(defun branch (kind value)
  (make-instance 'branch
                 :kind kind
                 :value value))

(defmacro define-branch-class (name tag)
  (let ((cname (read-from-string
                 (concatenate 'string "[" (symbol-name name) "]"))))
  `(progn
     (defclass ,cname (branch) ())
     (defun ,name (value)
       (make-instance (quote ,cname)
                      :kind ,tag
                      :value value)))))

(defmethod print-object ((obj branch) stream)
  (print-unreadable-object (obj stream :type t)
    (with-accessors ((value value)) obj
      (format stream "~a" value))))


(defclass node ()
  ((kind :INITARG :kind :READER kind)
   (left :INITARG :left :READER left)
   (right :INITARG :right :READER right)))

(defun node (kind left right)
  (make-instance 'node
                 :kind kind
                 :left left
                 :right right))

(defmethod print-object ((obj node) stream)
  (print-unreadable-object (obj stream :type t)
    (with-accessors ((left left)
                     (right right)) obj
      (format stream "~a ~a" left right))))


(defmacro define-node-class (name tag)
  (let ((cname (read-from-string
                 (concatenate 'string "[" (symbol-name name) "]")))
        (rname (read-from-string
                 (concatenate 'string "r" (symbol-name name)))))
    `(progn
       (defclass ,cname (node) ())
       (defun ,name (left right)
         (make-instance (quote ,cname)
                        :kind ,tag
                        :left left
                        :right right))
       (defun ,rname (left right)
         (make-instance (quote ,cname)
                        :kind ,tag
                        :left right
                        :right left)))))

(define-branch-class num :num)
(define-branch-class ident :ident)
(define-node-class n+ :+)
(define-node-class n- :-)
(define-node-class n/ :/)
(define-node-class n* :*)
(define-node-class n== :==)
(define-node-class n!= :!=)
(define-node-class n< :<)
(define-node-class n<= :<=)
(define-node-class n= :=)

(defgeneric is-addressable (node)
  (:method ((node [ident])) t)
  (:method ((node t)) nil))

;; (macroexpand-1 '(define-node-class n<= :<=))

