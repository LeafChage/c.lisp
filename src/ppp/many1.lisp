(in-package :ppp)

(defclass many1-parser (parser)
  ((child-parser :INITARG :parser)))

(defmethod parse ((obj many1-parser) text)
  (with-slots ((child child-parser)) obj
    (let* ((r (parse (many child) text))
           (unwrapped (result:unwrap r)))
      (if (null (car unwrapped))
          (result:fail "parsed error")
          (result:success unwrapped)))))


(defun many1 (p)
  (make-instance 'many1-parser :parser p))

;; (print (parse (many1 (digit)) "1111h"))
;; (print (parse (many1 (digit)) "hh"))

