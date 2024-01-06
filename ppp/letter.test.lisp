(in-package ppp/test)

(test test-letter
  (is (@eq (parse (letter) "hello")
           (result:ok '("h" "ello"))))

  (is-false (result:ok? (parse (letter) "")))
  (is-false (result:ok? (parse (letter) "12345"))))

;; (run! 'test-letter)
