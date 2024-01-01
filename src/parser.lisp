(in-package :cl-user)
(defpackage c.parser
  (:NICKNAMES :parser)
  (:use :cl)
  (:IMPORT-FROM :ppp)
  (:EXPORT #:c))
(in-package :c.parser)

;; (defparameter SEMI :semicolon)
;; (defparameter [=]  :equal)
;; (defparameter [!]  :exclamation)
;; (defparameter [{]  :paren-m-left)
;; (defparameter [}]  :paren-m-right)
;; (defparameter [[]  :paren-l-left)
;; (defparameter []]  :paren-l-right)

;; (defparameter *MOD*           (ppp:>> (ppp:token "%") (lambda (_) [%])))
;; (defparameter *SEMICOLON*     (ppp:>> (ppp:token ";") (lambda (_) SEMI)))
;; (defparameter *EQUAL*         (ppp:>> (ppp:token "=") (lambda (_) [=])))
;; (defparameter *EXCLAMATION*   (ppp:>> (ppp:token "!") (lambda (_) [!])))
;; (defparameter *PAREN-M-LEFT*  (ppp:>> (ppp:token "{") (lambda (_) [{])))
;; (defparameter *PAREN-M-RIGHT* (ppp:>> (ppp:token "}") (lambda (_) [}])))
;; (defparameter *PAREN-L-LEFT*  (ppp:>> (ppp:token "[") (lambda (_) [[])))
;; (defparameter *PAREN-L-RIGHT* (ppp:>> (ppp:token "]") (lambda (_) []])))


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

;; mul     = primary ("*" primary | "/" primary)*
(defun mul ()
  (exwhitespace
    (ppp:>>
      (ppp:&& (primary)
              (ppp:many (ppp:|| (ppp:&& (multiple) (primary))
                                (ppp:&& (devide) (primary)))))
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

(ppp:parse (expr) "1 + 2  +2 * 2 / 4 * (1 + 2)")
