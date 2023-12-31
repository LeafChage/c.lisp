(defpackage c.parser
  (:use
    :cl
    :c.parser.core))
(in-package :c.parser)

(defun c ()
  (p:&&
    (p:digit)
    (p:token "+")
    (p:digit)
    (p:token "+")
    (p:digit)
    ;; (p:||
    ;;   (p:token "+")
    ;;   (p:token "-")
    ;;   (p:token "*")
    ;;   (p:token "/")
    ;;   (p:token "%"))
    ))

(funcall  (c) "1+2+3")
