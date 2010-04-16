(defun wd-at-company ()
  ;; (message "瞅瞅我们是不是在公司网络呢…")
  (if (>
       (length
        (shell-command-to-string
         "grep ali.com /etc/resolv.conf")) 0)
      t
    nil)
  )
(setq wd-at-company? (wd-at-company))

(provide 'wd-var)
