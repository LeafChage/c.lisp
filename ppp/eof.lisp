(in-package :cl-user)
(defpackage :ppp/eof
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from :ppp/parser)
  (:import-from :ppp/error)
  (:export #:eof))
(in-package :ppp/eof)

(defclass eof-parser (ppp/parser:parser) ())

(defmethod ppp/parser:parse ((p eof-parser)
                             (text sequence))
  (if (string= text "")
      (result:ok (list (string #\0) ""))
      (ppp/error:parser-err :expect (string #\0)
                            :actual (elt text 0))))

(defun eof ()
  (make-instance 'eof-parser))

