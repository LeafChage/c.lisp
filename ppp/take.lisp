(in-package :cl-user)
(defpackage :ppp/take
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:import-from #:ppp/error)
  (:import-from #:ppp/util)
  (:export #:take))
(in-package :ppp/take)

(defclass take-parser (ppp/parser:parser)
  ((n :INITARG :length)))

(defmethod ppp/parser:parse ((p take-parser)
                  (text sequence))
  (with-slots ((n n)) p
    (if (> (length text) n)
        (result:ok (ppp/util:split text n))
        (ppp/error:parser-err :expect (format nil "~v@{~A~:*~}" n "*")
                              :actual text))))

(defun take (n)
  (make-instance 'take-parser :length n))

