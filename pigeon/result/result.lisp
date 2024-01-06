(in-package :cl-user)
(defpackage pigeon/result
  (:nicknames :result)
  (:use :cl
        :pigeon/core)
  (:export :ok
           #:ok
           :err
           #:err
           #:->
           #:->>
           #:e->
           #:e->>
           #:result?
           #:ok?
           #:match
           #:unwrap))
(in-package pigeon/result)

(defclass |result| ()
  ((val :INITARG :val :READER read-val)))

(defgeneric result? (r)
  (:method ((_ |result|)) t)
  (:method ((_ t)) nil))

(defclass ok (|result|)())
(defclass err (|result|)())

(defun ok (v)
  (make-instance 'ok :val v))

(defun err (v)
  (make-instance 'err :val v))

(defmethod @eq ((result1 ok) (result2 ok))
  (@eq (read-val result1)
       (read-val result2)))

(defmethod @eq ((result1 err) (result2 err))
  (@eq (read-val result1)
       (read-val result2)))

(defmethod @eq ((result1 |result|) (result2 |result|))
  nil)

(defgeneric -> (r fn)
  (:method ((result ok) (fn function))
    (ok (funcall fn (read-val result))))

  (:method ((result err) (fn t))
    result)

  (:method ((result t) (fn t))
    (error "unreachable")))

(defgeneric e-> (r fn)
  (:method ((result ok) (fn t))
    result)

  (:method ((result err) (fn function))
    (err (funcall fn (read-val result))))

  (:method ((result t) (fn t))
    (error "unreachable")))

(defgeneric ->> (r fn)
  (:method ((result ok) (fn function))
    (funcall fn (read-val result)))

  (:method ((result err) (fn t))
    result)

  (:method ((result t) (fn t))
    (error "unreachable")))

(defgeneric e->> (r fn)
  (:method ((result ok) (fn t))
    result)

  (:method ((result err) (fn function))
    (funcall fn (read-val result)))

  (:method ((result t) (fn t))
    (error "unreachable")))

(defgeneric ok? (r)
  (:method ((_ ok)) t)
  (:method ((_ t)) nil))

(defmethod print-object ((result |result|) stream)
  (print-unreadable-object (result stream :type t)
    (format stream "~a" (read-val result))))

(defgeneric match (r ok-fn err-fn)
  (:method ((result ok) (ok-fn function) (_ t))
    (funcall ok-fn (read-val result)))

  (:method ((result err) (_ t) (err-fn function))
    (funcall err-fn (read-val result)))

  (:method ((a t) (b  t) (c t))
    (error "unreachable")))

(defgeneric unwrap (r)
  (:method ((result ok))
    (read-val result))
  (:method ((result t))
    (error "this result is error")))


