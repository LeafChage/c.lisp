(in-package :cl-user)
(defpackage :ppp/check
  (:use :cl
        :pigeon)
  (:import-from #:ppp/parser)
  (:export #:check))
(in-package :ppp/check)

(defclass check-parser (ppp/parser:parser)
  ((p :INITARG :p)
   (success? :INITARG :success?)))

(defmethod ppp/parser:parse ((p check-parser) (text sequence))
  (with-slots ((p p)
               (success? success?)) p
    (result:->> (ppp/parser:parse p text)
                (lambda (v)
                  (if (funcall success? (car v))
                      (result:ok v)
                      (result:err "failed check"))))))

(defmethod check ((p ppp/parser:parser)
                  (success function))
  (make-instance 'check-parser :p p :success? success))

