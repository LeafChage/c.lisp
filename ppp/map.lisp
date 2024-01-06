(in-package :cl-user)
(defpackage :ppp/map
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from #:ppp/parser)
  (:export #:->))
(in-package :ppp/map)

(defclass map-parser (ppp/parser:parser)
  ((p :INITARG :p)
   (fn :INITARG :fn)))

(defmethod ppp/parser:parse ((p map-parser)
                             (text sequence))
  (with-slots ((p p) (fn fn)) p
    (result:->> (ppp/parser:parse p text)
                (lambda (v)
                  (let ((target (car v)))
                    (result:ok
                      (list (funcall fn target)
                            (cadr v))))))))

(defmethod -> ((p ppp/parser:parser)
               (fn function))
  (make-instance 'map-parser :p p :fn fn))

