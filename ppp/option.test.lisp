(in-package ppp/test)

(test test-option
  (is (@eq (parse (option (digit)) "hhhhh")
           (result:ok '(nil "hhhhh"))))
  (is (@eq (parse (option (digit)) "12345")
           (result:ok '("1" "2345")))))

;; (run! 'test-option)
