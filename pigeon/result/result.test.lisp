(in-package :cl-user)
(defpackage pigeon/result/test
  (:use :cl
        :fiveam
        :pigeon/core
        :pigeon/result))
(in-package pigeon/result/test)

(def-suite pigeon-result-compare-test)
(in-suite pigeon-result-compare-test)

(test |->|
  (is (@eq (-> (ok 1)
               (lambda (v) (+ v 1)))
           (ok 2)))
  (is (@eq (-> (err "error")
               (lambda (v) (+ v 1)))
           (err "error"))))

(test |->>|
  (is (@eq (->> (ok 1)
               (lambda (v) (+ v 1)))
           2))
  (is (@eq (->> (err "error")
               (lambda (v) (+ v 1)))
           (err "error"))))

(test |e->|
  (is (@eq (e-> (ok 1)
               (lambda (v) (+ v 1)))
           (ok 1)))
  (is (@eq (e-> (err 1)
               (lambda (v) (+ v 1)))
           (err 2))))

(test |e->>|
  (is (@eq (e->> (ok 1)
               (lambda (v) (+ v 1)))
           (ok 1)))
  (is (@eq (e->> (err 1)
               (lambda (v) (+ v 1)))
           2)))


(test |ok?|
  (is-true (ok? (ok 1)))
  (is-false (ok? (err 1))))

(test |match|
  (is (@eq (match (ok 1)
                    (lambda (v) (+ v 1))
                    nil)
           2))
  (is (@eq (match (err 1)
                    nil
                    (lambda (v) (+ v 1)))
           2)))

(test |unwrap|
  (is-true (@eq (unwrap (ok 1)) 1))
  (signals (error "this result is error")
    (unwrap (err "hi"))))

(run!)
