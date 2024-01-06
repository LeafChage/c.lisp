(in-package ppp/test)

(test test-digit
  (is (@eq (parse (digit) "123")
           (result:ok '("1" "23"))))

  (is-false (result:ok? (parse (digit) "")))
  (is-false (result:ok? (parse (digit) "hello"))))

;; (run! 'test-digit)
