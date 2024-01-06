(in-package :cl-user)
(defpackage :ppp/choice
  (:use :cl)
  (:import-from #:ppp/parser)
  (:export #:choice))
(in-package :ppp/choice)

(defclass choice-parser (ppp/parser:parser)
  ((parsers :INITARG :parsers)))


(defmethod e->> ((e1 result:err)
                 (e2 result:err)
                 (f function))
  (let ((v1 (result:e->> e1 (lambda (v) v)))
        (v2 (result:e->> e2 (lambda (v) v))))
    (funcall f v1 v2)))

(defmethod merge-error ((e1 result:err)
                        (e2 result:err))
  (e->> e1 e2 (lambda (v1 v2)
                (ppp/error:parser-err
                  :expect (list (ppp/error:expect v1)
                                (ppp/error:expect v2))
                  :actual (ppp/util:longer (ppp/error:actual v1)
                                           (ppp/error:actual v2))))))


(defmethod ppp/parser:parse ((obj choice-parser) text)
  (with-slots ((parsers parsers)) obj
    (let ((results (loop for p in parsers
                         for r = (ppp/parser:parse p text)
                         collect r
                         when (result:ok? r)
                         return r)))
      (if (not (listp results))
          results
          (reduce #'merge-error results)))))

(defun choice (&rest parsers)
  (make-instance 'choice-parser :parsers parsers))


