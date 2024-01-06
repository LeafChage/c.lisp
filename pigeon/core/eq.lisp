(in-package :pigeon/core)

(defgeneric @eq (a b)
  (:documentation "check equality")
  (:method ((a t) (b t))
    (error "not comparable [~a], [~a]" (type-of a) (type-of b))))

(defmethod @eq ((a number) (b number))
  (eq a b))

(defmethod @eq ((a sequence) (b sequence))
  (equal a b))

(defmethod @eq ((a character) (b character))
  (eq a b))

(defmethod @eq ((a symbol) (b symbol))
  (eq a b))

(defmethod @eq ((a list) (b list))
  (equal a b))


