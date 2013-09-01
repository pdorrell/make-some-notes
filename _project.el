(load-this-project
 `( (:ruby-executable ,*ruby-1.9-executable*)
    (:build-function project-compile-with-command)
    (:compile-command "berake")
    (:ruby-args ())
    (:run-project-command (run-rails-server 
			   ,(concat (expand-file-name (project-base-directory)) "scripts/run-rails-server")
			   ,(concat (expand-file-name (project-base-directory)))))
    (:run-database-command (start-process-showing-console 
			    "postgres" "*postgres*"
			    ,(concat (expand-file-name (project-base-directory)) "scripts/run-postgres-server")
			    ,(expand-file-name (project-base-directory)) ))
    ) )
