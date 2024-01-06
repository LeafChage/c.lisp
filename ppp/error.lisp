(in-package :cl-user)
(defpackage ppp/error
  (:use :cl
        :pigeon)
  (:export #:parser-err
           #:expect
           #:actual))
(in-package :ppp/error)

(defclass parser-err ()
  ((expect :INITARG :expect :READER expect)
   (actual :INITARG :actual :READER actual)))

(defun parser-err (&key expect actual)
  (result:err (make-instance 'parser-err
                             :expect expect
                             :actual actual)))

(defmethod print-object ((e parser-err) stream)
  (print-unreadable-object (e stream :type t)
    (format stream "expect ~a / actual ~a"
            (expect e)
            (actual e))))

