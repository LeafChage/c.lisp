(in-package :cl-user)
(defpackage :ppp/lazy
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:export #:lazy))
(in-package :ppp/lazy)

(defclass lazy-parser (ppp/parser:parser)
  ((generator :INITARG :gene)))

(defmethod ppp/parser:parse ((obj lazy-parser) text)
  (with-slots ((g generator)) obj
    (ppp/parser:parse (funcall g) text)))

(defmethod lazy ((fn function))
  (make-instance 'lazy-parser :gene fn))


