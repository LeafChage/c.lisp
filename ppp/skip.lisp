(in-package :cl-user)
(defpackage :ppp/skip
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:export #:skip))
(in-package :ppp/skip)

(defclass skip-parser (ppp/parser:parser)
  ((p1 :INITARG :p1)
   (p2 :INITARG :p2)))

(defmethod ppp/parser:parse ((p skip-parser)
                             (text sequence))
  (with-slots ((p1 p1) (p2 p2)) p
    (result:->> (ppp/parser:parse p1 text)
                (lambda (val1)
                  (result:->> (ppp/parser:parse p2 (cadr val1))
                              (lambda (val2)
                                (result:ok (list (car val1) (cadr val2)))))))))

(defmethod skip ((p1 ppp/parser:parser)
                 (p2 ppp/parser:parser))
  (make-instance 'skip-parser :p1 p1 :p2 p2))



