(in-package :cl-user)
(defpackage ppp
  (:NICKNAMES :ppp)
  (:use :cl)
  (:IMPORT-FROM
    :ppp.util
    :ppp.result
    :str)
  (:EXPORT :ppp.result
           :parser
           #:parse
           #:any
           #:digit
           #:letter
           #:take
           #:token
           #:many
           #:&&
           #:||
           #:>>
           #:devide-by
           #:choice
           #:skip
           #:whitespace
           #:whitespaces))

