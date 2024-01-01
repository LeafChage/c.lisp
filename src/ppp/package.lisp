(in-package :cl-user)
(defpackage ppp
  (:NICKNAMES :ppp)
  (:use :cl
        :alexandria)
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
           #:many1
           #:&&
           #:||
           #:>>
           #:devide-by
           #:choice
           #:skip
           #:with
           #:lazy
           #:option
           #:whitespace
           #:whitespaces))

