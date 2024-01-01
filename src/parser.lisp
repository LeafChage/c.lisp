(in-package :cl-user)
(defpackage c.parser
  (:NICKNAMES :parser)
  (:use :cl)
  (:IMPORT-FROM :ppp)
  (:EXPORT #:c))
(in-package :c.parser)

(defun exwhitespace (p)
  (ppp:with (ppp:whitespaces) p))

(defun reserved (target token)
  (exwhitespace (ppp:>> (ppp:token target)
                        (lambda (_) token) )))

(defun plus () (reserved "+" :+))
(defun minus () (reserved "-" :-))
(defun devide () (reserved "/" :/))
(defun multiple () (reserved "*" :*))

(defun num ()
  (exwhitespace
    (ppp:>> (ppp:many1 (ppp:digit))
            (lambda (v) (list :num
                              (apply #'concatenate 'string v))))))

;; primary = num | "(" expr ")"
(defun primary ()
  (exwhitespace
    (ppp:|| (num)
            (ppp:>>
              (ppp:&& (ppp:token "(") (ppp:lazy #'expr) (ppp:token ")"))
              (lambda (v) (caadr v))))))

;; unary = ("+" | "-")? primary
(defun unary ()
  (exwhitespace
    (ppp:choice
      (ppp:>>
        (ppp:&& (ppp:option (ppp:token "+"))
                (primary))
        (lambda (v) (cadr v)))
      (ppp:>>
        (ppp:&& (ppp:option (ppp:token "-"))
                (primary))
        (lambda (v) (list :- '(:num 0) (cadr v)))))))


;; mul     = unary ("*" unary | "/" unary)*
(defun mul ()
  (exwhitespace
    (ppp:>>
      (ppp:&& (unary)
              (ppp:many (ppp:|| (ppp:&& (multiple) (unary))
                                (ppp:&& (devide) (unary)))))
      (lambda (v) (reduce (lambda (a b) (list (car b) a (cadr b)))
                          (cons (car v) (cadr v)))))))

;; expr = mul ("+" mul | "-" mul)*
(defun expr ()
  (exwhitespace
    (ppp:>>
      (ppp:&& (mul)
              (ppp:many (ppp:|| (ppp:&& (plus) (mul))
                                (ppp:&& (minus) (mul)))))
      (lambda (v) (reduce (lambda (a b) (list (car b) a (cadr b)))
                          (cons (car v) (cadr v)))))))

(defun c (txt)
  (car (ppp.result::unwrap
         (ppp:parse (expr) txt))))

;; (ppp:parse (expr) "1 + 2  +2 * 2 / 4 * (1 + 2)")
