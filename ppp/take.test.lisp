(in-package ppp/test)

(test test-take
  (is (@eq (parse (take 3) "helloworld")
           (result:ok '("hel" "loworld"))))

  (is-false (result:ok? (parse (take 6) "hello"))))

;; (run! 'test-take)
