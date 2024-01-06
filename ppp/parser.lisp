(in-package :cl-user)
(defpackage :ppp/parser
  (:use :cl)
  (:export :parser
           #:parse))
(in-package :ppp/parser)

(defclass parser ()
  ())

(defgeneric parse (obj text)
  (:method (obj text)
    (error "unimplemented")))
