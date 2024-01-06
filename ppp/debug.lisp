(in-package :cl-user)
(defpackage :ppp/debug
  (:use :cl)
  (:import-from #:ppp/parser)
  (:export #:dbg))
(in-package :ppp/debug)

(defclass debug-parser (ppp/parser:parser)
  ((generator :INITARG :gene)))

(defmethod ppp/parser:parse ((obj debug-parser) text)
  (with-slots ((g generator)) obj
    (step (ppp/parser:parse (funcall g) text))))

(defmethod dbg ((fn function))
  (make-instance 'debug-parser :gene fn))

;; (print (parse (dbg #'digit) "1111h"))
