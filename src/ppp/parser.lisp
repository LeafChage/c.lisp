(in-package :ppp)

(defclass parser () ())

(defgeneric parse (obj text)
  (:method (obj text)
    (result:fail "unimplemented")))

;; (defmethod & ((p1 parser) (p2 parser))
;;   (lambda (text)
;;     (let ((r (funcall p1 text)))
;;       (result:match=>
;;         r
;;         (lambda (val1)
;;           (let ((r2 (funcall p2  (cadr val1))))
;;             (result:match=>
;;               r2
;;               (lambda (val2)
;;                 (result:success (list
;;                                   (list (car val1) (car val2))
;;                                   (cdr val2))))
;;               (lambda (e2) (result:fail e2)))))
;;         (lambda (e1) (result:fail e1))))))
;; ;; (result:>> (funcall (& (token "hello") (take 5)) "hello123456") #'car)
;;
;; (defmethod && ((ps &rest parser))
;;   (let ((tail (cdr ps)))
;;     (if (null tail)
;;         (car ps)
;;         (& (car ps) (apply #'&& tail)))))
;; ;; (result:>> (funcall (&& (token "hello") (take 5)) "hello123456") #'car)
;; ;; (result:>> (funcall (&& (any) (any) (any)) "hello123456") #'car)
;;
;; (defpackage test
;;   (:NICKNAMES :parser.core)
;;   (:use
;;     :cl
;;     )
;;   (:EXPORT
;;     :parser
;;     #:||
;;     #:&&))
;; (in-package :test)
