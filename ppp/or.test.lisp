(in-package ppp/test)

(test |or|
  (is (@eq (parse (|| (token "hello")
                      (token "world")) "helloworld")
           (result:ok '("hello" "world"))))

  (is (@eq (parse (|| (token "hello")
                      (token "world")) "world")
           (result:ok '("world" ""))))

  (is-false (result:ok? (parse (|| (token "hello")
                                   (token "world"))
                               "hogehoge"))))

;; (run! '|or|)
