(let ((my-project-path (merge-pathnames "project/c/" (user-homedir-pathname))))
  (pushnew my-project-path asdf:*central-registry* :test #'equal))


