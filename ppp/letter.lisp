(in-package :cl-user)
(defpackage :ppp/letter
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:import-from #:ppp/error)
  (:import-from #:ppp/util)
  (:export #:letter))
(in-package :ppp/letter)

(defclass letter-parser (ppp/parser:parser) ())

(defparameter +letter+ "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

(defmethod ppp/parser:parse ((p letter-parser)
                             (text sequence))
  (if (not (> (length text) 0))
      (ppp/error:parser-err :expect +letter+
                            :actual "")
      (let ((v (ppp/util:split text 1)))
        (if (str:contains? (car v) +letter+)
            (result:ok v)
            (ppp/error:parser-err :expect +letter+
                                  :actual (car v))))))


(defun letter ()
  (make-instance 'letter-parser))
