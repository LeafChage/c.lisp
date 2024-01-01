(in-package :ppp)

(defclass parser () ())

(defgeneric parse (obj text)
  (:method (obj text)
    (result:fail "unimplemented")))

