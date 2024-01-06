(in-package :cl-user)
(defpackage c.parser
  (:NICKNAMES :parser)
  (:use :cl)
  (:IMPORT-FROM :pigeon)
  (:IMPORT-FROM :ppp)
  (:IMPORT-FROM :c.node)
  (:EXPORT #:c))
(in-package :c.parser)

(defun skipw (p)
  (ppp:with (ppp:whitespaces) p))

(defparameter |p+|  (skipw (ppp:token "+")))
(defparameter |p-|  (skipw (ppp:token "-")))
(defparameter |p/|  (skipw (ppp:token "/")))
(defparameter |p*|  (skipw (ppp:token "*")))
(defparameter |p==| (skipw (ppp:token "==")))
(defparameter |p!=| (skipw (ppp:token "!=")))
(defparameter |p<|  (skipw (ppp:token "<")))
(defparameter |p<=| (skipw (ppp:token "<=")))
(defparameter |p>|  (skipw (ppp:token ">")))
(defparameter |p>=| (skipw (ppp:token ">=")))
(defparameter |p=|  (skipw (ppp:token "=")))
(defparameter |p;|  (skipw (ppp:token ";")))
(defparameter |p(|  (skipw (ppp:token "(")))
(defparameter |p)|  (skipw (ppp:token ")")))

(defparameter num (skipw (ppp:-> (ppp:many1 (ppp:digit))
                                 (lambda (v) (node:num (apply #'concatenate 'string v))))))

(defparameter ident (skipw (ppp:-> (ppp:many1 (ppp:letter))
                                   (lambda (v) (node:ident (apply #'concatenate 'string v))))))

;; primary = num | ident | "(" expr ")"
(defun primary ()
  (ppp:choice
    num
    ident
    (ppp:->
      (ppp:&& |p(| (ppp:lazy #'expr) |p)| )
      (lambda (v) (caadr v)))))

;; unary = ("+" | "-")? primary
(defun unary ()
  (ppp:choice
    (ppp:->
      (ppp:with |p+| (primary))
      (lambda (v) (cadr v)))
    (ppp:->
      (ppp:with |p-| (primary))
      (lambda (v) (node:n- (node:num 0) (cadr v))))
    (primary)))


;; mul     = unary ("*" unary | "/" unary)*
(defun mul ()
  (ppp:choice
    (ppp:->
      (ppp:&& (unary)
              (ppp:many1 (ppp:with |p/| (unary))))
      (lambda (v) (reduce #'node:n/ (cons (car v) (cadr v)))))
    (ppp:->
      (ppp:&& (unary)
              (ppp:many1 (ppp:with |p*| (unary))))
      (lambda (v) (reduce #'node:n* (cons (car v) (cadr v)))))
    (unary)))

;; add = mul ("+" mul | "-" mul)*
(defun add  ()
  (ppp:choice
    (ppp:->
      (ppp:&& (mul)
              (ppp:many1 (ppp:with |p+| (mul))))
      (lambda (v) (reduce #'node:n+ (cons (car v) (cadr v)))))
    (ppp:->
      (ppp:&& (mul)
              (ppp:many1 (ppp:with |p-| (mul))))
      (lambda (v) (reduce #'node:n- (cons (car v) (cadr v)))))
    (mul)))

;; relational = add ("<" add | "<=" add | ">" add | ">=" add)*
(defun relational ()
  (ppp:choice
    (ppp:->
      (ppp:&& (add)
              (ppp:many1 (ppp:with |p<| (add))))
      (lambda (v) (reduce #'node:n< (cons (car v) (cadr v)))))
    (ppp:->
      (ppp:&& (add)
              (ppp:many1 (ppp:with |p<=| (add))))
      (lambda (v) (reduce #'node:n<= (cons (car v) (cadr v)))))
    (ppp:->
      (ppp:&& (add)
              (ppp:many1 (ppp:with |p>| (add))))
      (lambda (v) (reduce #'node:rn< (cons (car v) (cadr v)))))
    (ppp:->
      (ppp:&& (add)
              (ppp:many1 (ppp:with |p>=| (add))))
      (lambda (v) (reduce #'node:rn<= (cons (car v) (cadr v)))))
    (add)))

;; equality = relational ("==" relational | "!=" relational)*
(defun equality ()
  (ppp:choice
    (ppp:->
      (ppp:&& (relational)
              (ppp:many1 (ppp:with |p==| (relational))))
      (lambda (v) (reduce #'node:n== (cons (car v) (cadr v)))))
    (ppp:->
      (ppp:&& (relational)
              (ppp:many1 (ppp:with |p!=| (relational))))
      (lambda (v) (reduce #'node:n!= (cons (car v) (cadr v)))))
    (relational)))

;; assign = equality ("=" assign)?
(defun assign ()
  (ppp:choice
    (ppp:->
      (ppp:&& (ppp:check (equality) #'node:is-addressable)
              (ppp:with |p=| (ppp:lazy #'assign)))
      (lambda (v) (node:n= (car v) (cadr v))))
    (equality)))

;; expr = equality
(defun expr ()
  (assign))

;; stmt = expr ;
(defun stmt ()
  (ppp:-> (ppp:&& (expr) |p;|)
          (lambda (v) (car v))))

;; program    = stmt*;
(defun program ()
  (ppp:many (stmt)))

(defun c (txt)
  (car (car (result::unwrap
         (ppp:parse (program) txt)))))

;; (ppp:parse (program) "1 = 1+2;")
;; (ppp:parse (program) "1+2;")
;; (ppp:parse (program) "a = 1 + 2 + 3;")
;; (ppp:parse (expr) "1 >= 2")
;; (ppp:parse (expr) "2 <= 1")

