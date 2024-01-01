(in-package :ppp)

(defun whitespace ()
  (skip (choice
          (token " ")
          (token (string #\newline))
          (token (string #\tab)))))
;; (parse (whitespace) " hello")
;; (parse (whitespace) " hello")

(defun whitespaces ()
  (skip (many (choice
          (token " ")
          (token (string #\newline))
          (token (string #\tab))))))

;; (parse (whitespaces) "
;;        hello")
