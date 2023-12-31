(in-package :cl-user)
(defpackage :ppp.util
  (:NICKNAMES :util)
  (:use :cl
        :str)
  (:EXPORT #:split))
(in-package :ppp.util)

(defun split (text n)
  (list (str:substring 0 n text)
        (str:substring n (length text) text)))

