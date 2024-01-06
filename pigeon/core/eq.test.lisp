(in-package :cl-user)
(defpackage pigeon/test/eq
  (:use :cl
        :fiveam
        :pigeon/core))
(in-package pigeon/test/eq)

(def-suite equal-test)
(in-suite equal-test)

(test condition-test
  (signals (error "not comparable")
        (@eq 1 "hi")))

(test number-test
  (is-true (@eq 1 1))
  (is-false (@eq 1 2)))

(test sequence-test
  (is-true (@eq "hello" "hello"))
  (is-false (@eq "hello" "world")))

(test simple-test
  (is-true (@eq :a :a))
  (is-false (@eq :a :b)))

(test list-test
  (is-true (@eq '(1 2 3) '(1 2 3)))
  (is-false (@eq '(1 2 3) '(1 2 4)))
  (is-true (@eq nil nil)))

(run!)
