(in-package :cl-user)
(defpackage ppp.result
  (:NICKNAMES :result)
  (:use :cl
        :ppp.util)
  (:EXPORT :result
           #:success
           #:fail
           #:>>
           #:ok?
           #:match=>
           #:result?
           #:unwrap
           #:error-composite
           ))
(in-package :ppp.result)

(defclass result ()
  ((ok :INITARG :ok :READER ok?)
   (val :INITARG :val :READER val)))

(defun success (v)
  (make-instance 'result :ok t :val v))

(defun fail (v)
  (make-instance 'result :ok nil :val v))

(defmethod >> ((v result) fn)
  (if (ok? v)
      (success (funcall fn (val v)))
      v))
  ;; (>> (success 123) (lambda (v) (+ v 1)))
  ;; (>> (fail "hi") (lambda (v) (+ v 1)))

(defmethod match=> ((v result) success-action fail-action)
  (if (ok? v)
      (funcall success-action (val v))
      (funcall fail-action (val v))))

(defmethod print-object ((r result) stream)
  (print-unreadable-object (r stream :type t)
    (with-accessors ( (val val)) r
      (if (ok? r)
          (format stream "OK!: ~a" val)
          (format stream "ERR: ~a" val)))))

(defmethod result? ((r result)) t)
(defmethod result? ((r t)) nil)

(defmethod error-composite (&rest rs)
  (let ((errors (loop for r in rs
                      collect (val r))))
    (fail (reduce (lambda (a b)
              (format nil "~a / ~a" a b))
            errors))))
;; (error-composite (fail "hi") (fail "hi"))

(defmethod unwrap ((r result))
  (if (ok? r)
      (val r)
      nil))

