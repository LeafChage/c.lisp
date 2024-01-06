(in-package ppp/test)

(test test-devide-by
  (is (@eq (parse (devide-by (digit)
                             (token "+"))
                  "1+1+1")
           (result:ok '(("1" "+" "1" "+" "1") ""))))


  (is-false (result:ok? (parse (devide-by (digit)
                                          (token "+"))
                               "h+h+H"))))

;; (run! 'test-devide-by)
