(in-package :ppp/test)

(test test-any
  (is (@eq (parse (any) "123")
           (result:ok '("1" "23"))))

  (is-false (result:ok? (parse (any) ""))))

;; (run! 'test-any)
