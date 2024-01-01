(in-package :ppp)

(defclass skip-parser (parser)
  ((child :INITARG :child)))

(defmethod parse ((obj skip-parser) text)
  (with-slots ((child child)) obj
    (parse (>> child (lambda (v) nil)) text)))

(defun skip (p)
  (make-instance 'skip-parser :child p))

;; (parse (skip (any)) "hello")

