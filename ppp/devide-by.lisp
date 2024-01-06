(in-package :cl-user)
(defpackage :ppp/devide-by
  (:use :cl
        :alexandria
        :pigeon)
  (:import-from :ppp/and #:&&)
  (:import-from :ppp/many #:many)
  (:import-from :ppp/parser)
  (:export #:devide-by))
(in-package :ppp/devide-by)

(defclass devide-by-parser (ppp/parser:parser)
  ((child-parser :INITARG :parser)
   (devide-parser :INITARG :devide)))

(defmethod ppp/parser:parse ((obj devide-by-parser) text)
  (with-slots ((child child-parser)
               (devide devide-parser)) obj
    (result:->> (ppp/parser:parse (many (&& child devide)) text)
                (lambda (v)
                  (result:->> (ppp/parser:parse child (cadr v))
                              (lambda (v2)
                                (result:ok (list
                                             (flatten (list (car v) (car v2)))
                                             (cadr v2)))))))))

(defmethod devide-by ((child ppp/parser:parser)
                      (devide ppp/parser:parser))
  (make-instance 'devide-by-parser
                 :parser child
                 :devide devide))

