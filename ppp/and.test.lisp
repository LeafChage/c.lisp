(in-package ppp/test)

(test |and|
  (is (@eq (parse (&& (take 2)
                      (any)
                      (any))
                  "hello")
           (result:ok '(("he"  ("l" "l")) "o"))))

  (is (@eq (parse (&& (take 2)
                      (&& (any) (any))
                      (any))
                  "hello")
           (result:ok '(("he"  (("l" "l") "o")) ""))))


  (is-false (result:ok? (parse (&& (digit)
                                   (token "e"))
                               "hello"))))

;; (run! '|and|)
