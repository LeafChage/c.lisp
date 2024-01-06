(in-package :cl-user)
(defpackage ppp/util
  (:use :cl)
  (:import-from :str)
  (:export #:split
           #:longer))
(in-package ppp/util)

(defun split (text n)
  (list (str:substring 0 n text)
        (str:substring n (length text) text)))

(defmethod longer ((a sequence) (b sequence))
  (if (> (length a) (length b))
      a
      b))

