;; (defpackage c.parser.core
;;   (:NICKNAMES :p)
;;   (:use
;;     :cl
;;     :str
;;     :c.parser.core.result
;;     )
;;   (:EXPORT
;;     #:token
;;     #:take
;;     #:digit
;;     #:||
;;     #:&&
;;     ))
;; (in-package :c.parser.core)
;;
;; (defun >> (p fn)
;;   (lambda (text)
;;     (let ((r (funcall p text)))
;;       (result:>> r fn))))
;;
;; (print (funcall (funcall
;;          (>> (digit) (lambda (v) (+ 1 v)))
;;          "123") "123"))
;;
;; (defun || (p1 p2)
;;   ;; (print (let ((p (|| (token "12345") (take 5))))
;;   ;;          (funcall p "hello123456")))
;;   ;; (print (let ((p (|| (token "12345") (token "32424"))))
;;   ;;          (funcall p "hello123456")))
;;   (lambda (text)
;;     (let ((p1-r (funcall p1 text)))
;;       (result:match=>
;;         p1-r
;;         (lambda (v) (result:success v))
;;         (lambda (e1)
;;           (let ((p2-r (funcall p2 text)))
;;             (result:match=>
;;               p2-r
;;               (lambda (v) (result:success v))
;;               (lambda (e2)
;;                 (result:fail (format t "~a / ~a" e1 e2))))))))))
;;
