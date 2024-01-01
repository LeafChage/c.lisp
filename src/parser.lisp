(in-package :cl-user)
(defpackage c.parser
  (:NICKNAMES :parser)
  (:use :cl)
  (:IMPORT-FROM :ppp)
  (:EXPORT #:c
           :[+]
           :[-]
           :[/]
           :[*]
           :[%]
           :SEMI
           :[=]
           :[!]
           :[{]
           :[}]
           :[[]
           :[]]))
(in-package :c.parser)

(defparameter [+]  :plus)
(defparameter [-]  :minus)
(defparameter [/]  :devide)
(defparameter [*]  :multiple)
(defparameter [%]  :mod)
(defparameter SEMI :semicolon)
(defparameter [=]  :equal)
(defparameter [!]  :exclamation)
(defparameter [{]  :paren-m-left)
(defparameter [}]  :paren-m-right)
(defparameter [[]  :paren-l-left)
(defparameter []]  :paren-l-right)

;; (defun type-token (token)
;;   (:type . token))

(defparameter *PLUS*          (ppp:>> (ppp:token "+") (lambda (_) [+])))
(defparameter *MINUS*         (ppp:>> (ppp:token "-") (lambda (_) [-])))
(defparameter *DEVIDE*        (ppp:>> (ppp:token "/") (lambda (_) [/])))
(defparameter *MULTIPLE*      (ppp:>> (ppp:token "*") (lambda (_) [*])))
(defparameter *MOD*           (ppp:>> (ppp:token "%") (lambda (_) [%])))
(defparameter *SEMICOLON*     (ppp:>> (ppp:token ";") (lambda (_) SEMI)))
(defparameter *EQUAL*         (ppp:>> (ppp:token "=") (lambda (_) [=])))
(defparameter *EXCLAMATION*   (ppp:>> (ppp:token "!") (lambda (_) [!])))
(defparameter *PAREN-M-LEFT*  (ppp:>> (ppp:token "{") (lambda (_) [{])))
(defparameter *PAREN-M-RIGHT* (ppp:>> (ppp:token "}") (lambda (_) [}])))
(defparameter *PAREN-L-LEFT*  (ppp:>> (ppp:token "[") (lambda (_) [[])))
(defparameter *PAREN-L-RIGHT* (ppp:>> (ppp:token "]") (lambda (_) []])))

(defparameter *type-int* (ppp:>> (ppp:token "int")
                                 (lambda (_) (type-token :int))))
(defun id ()
  (ppp:>> (ppp:many (ppp:letter))
          (lambda (v) (apply #'concatenate 'string v))))

(defparameter *NUMBER*   (ppp:>> (ppp:many (ppp:digit))
                                 (lambda (v) (apply #'concatenate 'string v))))
(defun c (txt)
  (car (ppp.result::unwrap
         (ppp:parse
           (ppp:&& *NUMBER*
                   (ppp:many (ppp:&&
                               (ppp:with (ppp:whitespaces) (ppp:choice *PLUS* *MINUS*))
                               (ppp:with (ppp:whitespaces) *NUMBER*))))
           txt))))

;; (print (ppp:parse (ppp:devide-by *NUMBER* (ppp:choice
;;                                             *PLUS*
;;                                             *MINUS*
;;                                             *DEVIDE*
;;                                             *MULTIPLE*
;;                                             *MOD*
;;                                             )) "1*1/2hello"))
;;
