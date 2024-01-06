(in-package ppp/test)

(test test-choice
  (is (@eq (parse (choice (digit)
                          (take 14)
                          (token "aaa"))
                  "aaahello")
           (result:ok '("aaa" "hello"))))


  (is-false (result:ok? (parse (choice (digit)
                                       (take 14)
                                       (token "hi"))
                               "aaahello"))))

;; (run! 'test-choice)
