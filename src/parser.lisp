(in-package :cl-user)
(defpackage c.parser
  (:NICKNAMES :parser)
  (:use :cl)
  (:IMPORT-FROM :ppp
                :c.node)
  (:EXPORT #:c))
(in-package :c.parser)

(defun skipw (p)
  (ppp:with (ppp:whitespaces) p))

(defun p+  () (skipw (ppp:token "+")))
(defun p-  () (skipw (ppp:token "-")))
(defun p/  () (skipw (ppp:token "/")))
(defun p*  () (skipw (ppp:token "*")))
(defun p== () (skipw (ppp:token "==")))
(defun p!= () (skipw (ppp:token "!=")))
(defun p<  () (skipw (ppp:token "<")))
(defun p<= () (skipw (ppp:token "<=")))
(defun p>  () (skipw (ppp:token ">")))
(defun p>= () (skipw (ppp:token ">=")))

(defun num ()
  (skipw
    (ppp:>> (ppp:many1 (ppp:digit))
            (lambda (v) (node:num (apply #'concatenate 'string v))))))

;; primary = num | "(" expr ")"
(defun primary ()
  (skipw
    (ppp:|| (num)
            (ppp:>>
              (ppp:&& (ppp:token "(") (ppp:lazy #'expr) (ppp:token ")"))
              (lambda (v) (caadr v))))))

;; unary = ("+" | "-")? primary
(defun unary ()
  (skipw
    (ppp:choice
      (ppp:>>
        (ppp:&& (ppp:option (p+))
                (primary))
        (lambda (v) (cadr v)))
      (ppp:>>
        (ppp:&& (ppp:option (p-))
                (primary))
        (lambda (v) (node:n- (node:num 0) (cadr v)))))))


;; mul     = unary ("*" unary | "/" unary)*
(defun mul ()
  (skipw
    (ppp:choice
      (ppp:>>
        (ppp:&& (unary)
                (ppp:many1 (ppp:with (p/) (unary))))
        (lambda (v) (reduce #'node:n/ (cons (car v) (cadr v)))))
      (ppp:>>
        (ppp:&& (unary)
                (ppp:many1 (ppp:with (p*) (unary))))
        (lambda (v) (reduce #'node:n* (cons (car v) (cadr v)))))
      (unary))))

;; add = mul ("+" mul | "-" mul)*
(defun add ()
  (skipw
    (ppp:choice
      (ppp:>>
        (ppp:&& (mul)
                (ppp:many1 (ppp:with (p+) (mul))))
        (lambda (v) (reduce #'node:n+ (cons (car v) (cadr v)))))
      (ppp:>>
        (ppp:&& (mul)
                (ppp:many1 (ppp:with (p-) (mul))))
        (lambda (v) (reduce #'node:n- (cons (car v) (cadr v)))))
      (mul))))

;; relational = add ("<" add | "<=" add | ">" add | ">=" add)*
(defun relational ()
  (skipw
    (ppp:choice
      (ppp:>>
        (ppp:&& (add)
                (ppp:many1 (ppp:with (p<) (add))))
        (lambda (v) (reduce #'node:n< (cons (car v) (cadr v)))))
      (ppp:>>
        (ppp:&& (add)
                (ppp:many1 (ppp:with (p<=) (add))))
        (lambda (v) (reduce #'node:n<= (cons (car v) (cadr v)))))
      (ppp:>>
        (ppp:&& (add)
                (ppp:many1 (ppp:with (p>) (add))))
        (lambda (v) (reduce #'node:rn< (cons (car v) (cadr v)))))
      (ppp:>>
        (ppp:&& (add)
                (ppp:many1 (ppp:with (p>=) (add))))
        (lambda (v) (reduce #'node:rn<= (cons (car v) (cadr v)))))
      (add))))

;; equality = relational ("==" relational | "!=" relational)*
(defun equality ()
  (skipw
    (ppp:choice
      (ppp:>>
        (ppp:&& (relational)
                (ppp:many1 (ppp:with (p==) (relational))))
        (lambda (v) (reduce #'node:n== (cons (car v) (cadr v)))))
      (ppp:>>
        (ppp:&& (relational)
                (ppp:many1 (ppp:with (p!=) (relational))))
        (lambda (v) (reduce #'node:n!= (cons (car v) (cadr v)))))
      (relational))))

;; expr       = equality
(defun expr()
    (skipw (equality)))

(defun c (txt)
  (car (ppp.result::unwrap
         (ppp:parse (expr) txt))))

;; (ppp:parse (expr) "1 * 2 + 2 * 2 * 4 * (1 + 2)")
;; (ppp:parse (expr) "1 * 2 + 2 * 2 * 4 * (1 + 2)")
;; (ppp:parse (expr) "1 >= 2")
;; (ppp:parse (expr) "2 <= 1")

