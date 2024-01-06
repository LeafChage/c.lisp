(in-package :cl-user)
(defpackage :ppp/with
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:export #:with))
(in-package :ppp/with)

(defclass with-parser (ppp/parser:parser)
  ((p1 :INITARG :p1)
   (p2 :INITARG :p2)))

(defmethod ppp/parser:parse ((p with-parser)
                             (text sequence))
  (with-slots ((p1 p1) (p2 p2)) p
    (result:->> (ppp/parser:parse p1 text)
                (lambda (val1)
                  (ppp/parser:parse p2 (cadr val1))))))

(defmethod with ((p1 ppp/parser:parser)
                 (p2 ppp/parser:parser))
  (make-instance 'with-parser :p1 p1 :p2 p2))

