(in-package :ppp)

(defclass choice-parser (parser)
  ((parsers :INITARG :parsers)))

(defmethod parse ((obj choice-parser) text)
  (with-slots ((parsers parsers)) obj
    (let ((results (loop for p in parsers
                         for r = (parse p text)
                         collect r
                         when (result:ok? r)
                         return r)))
      (if (not (listp results))
          results
          (apply #'result:error-composite results)))))

(defun choice (&rest parsers)
  (make-instance 'choice-parser :parsers parsers))

;; (parse (choice (take 7) (token "aaa") ) "hello")

