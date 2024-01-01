(in-package :cl-user)
(defpackage ppp.util
  (:NICKNAMES :util)
  (:USE :cl)
  (:IMPORT-FROM :str)
  (:EXPORT #:split
           #:flatten))
(in-package :ppp.util)

(defun split (text n)
  (list (str:substring 0 n text)
        (str:substring n (length text) text)))

(defun flatten (l)
  (cond ((null l) nil)
        ((atom (car l)) (cons (car l) (flatten (cdr l))))
        (t (append (flatten (car l)) (flatten (cdr l))))))

;; (flatten (list (list :a :b :c) (list (list :aa))))
