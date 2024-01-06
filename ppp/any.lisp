(in-package :cl-user)
(defpackage :ppp/any
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from :ppp/parser)
  (:import-from :ppp/error)
  (:import-from :ppp/util)
  (:export #:any))
(in-package :ppp/any)

(defclass any-parser (ppp/parser:parser) ())

(defmethod ppp/parser:parse ((p any-parser)
                  (text sequence))
  (if (> (length text) 0)
      (result:ok (ppp/util:split text 1))
      (ppp/error:parser-err :expect "*"
                            :actual :eof)))

(defun any ()
  (make-instance 'any-parser))


