(defpackage c/tests/main
  (:use :cl
        :c
        :rove))
(in-package :c/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :c)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
