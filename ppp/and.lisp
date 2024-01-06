(in-package :cl-user)
(defpackage :ppp/and
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/util)
  (:import-from #:ppp/parser)
  (:export #:&&))
(in-package :ppp/and)

(defclass and-parser (ppp/parser:parser)
  ((p1 :INITARG :p1)
   (p2 :INITARG :p2)))

(defmethod ppp/parser:parse ((p and-parser) text)
  (with-slots ((p1 p1)
               (p2 p2)) p
    (result:->> (ppp/parser:parse p1 text)
                (lambda (val1)
                  (result:->> (ppp/parser:parse p2  (cadr val1))
                              (lambda (val2)
                                (result:ok (list
                                             (list (car val1) (car val2))
                                             (cadr val2)))))))))

(defmethod & ((p1 ppp/parser:parser)
              (p2 ppp/parser:parser))
  (make-instance 'and-parser :p1 p1 :p2 p2))

(defun && (&rest ps)
  (cond ((> (list-length ps) 2) (& (car ps) (apply #'&& (cdr ps))))
        ((> (list-length ps) 1) (& (car ps) (cadr ps)))
        (t (error "argument error"))))



