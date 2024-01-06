(in-package :cl-user)
(defpackage :ppp/digit
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:import-from #:ppp/error)
  (:import-from #:ppp/util)
  (:export #:digit))
(in-package :ppp/digit)

(defclass digit-parser (ppp/parser:parser) ())

(defparameter +digit+ "0123456789")

(defmethod ppp/parser:parse ((p digit-parser)
                             (text sequence))
  (if (not (> (length text) 0))
      (ppp/error:parser-err :expect +digit+
                            :actual "")
      (let ((v (ppp/util:split text 1)))
        (if (str:contains? (car v) +digit+)
            (result:ok v)
            (ppp/error:parser-err :expect +digit+
                                  :actual (car v))))))


(defun digit ()
  (make-instance 'digit-parser))

