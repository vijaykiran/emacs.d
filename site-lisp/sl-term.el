;; ;; should i remove these?
;; (add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

;; (defun proc-filter-column-motion (&optional string)
;;   "Process column positioning escape sequences."
;;   (while (re-search-forward "\e\\[\\([0-9]+\\)G" nil t)
;;     (let ((n (string-to-int (buffer-substring (match-beginning 1)
;;                                               (match-end 1))))
;;           distance)
;;       (delete-region (match-beginning 0) (match-end 0))
;;       ;; current-column doesn't work when narrowing is in effect such that
;;       ;; column 0 isn't included in the region.
;;       (setq distance (- n (save-restriction (widen) (current-column))))
;;       (and (> distance 0)
;;            (insert-before-markers (make-string distance ?\x20))))))


;; term mode
(setq explicit-shell-file-name "bash")
;(eval-after-load 'term
;  '(term-set-escape-char ?\C-x))
;; term cannot track dir when setting this
;(setq term-term-name "linux")

;; modify ls colors (i cannot read directory name under tango theme)
;; (setq ansi-term-color-vector
;;   [unspecified "black" "red3" "lime green" "yellow3" "DeepSkyBlue3"
;;    "magenta3" "cyan3" "white"])

;; global terminal buffer list
(defvar sl-term-list nil
  "Global list hold the terminal buffer.")

;; kill terminal buffer on exit
;; stolen from multi-term
(defun sl/term-exit-close  ()
  (when (ignore-errors (get-buffer-process (current-buffer)))
    (set-process-sentinel (get-buffer-process (current-buffer))
                          (lambda (proc change)
                            (when (string-match "\\(finished\\|exited\\)" change)
                              (kill-buffer (process-buffer proc)))))))

(add-hook 'term-mode-hook 'sl/term-exit-close)

;; (term-set-escape-char ?\C-x)
;; 
(defun sl-term (&optional prog)
  "Make a new terminal or switch to an old one if exist."
  (interactive "P")
  ;; clear unusable buffer from list
  (setq sl-term-list
	(delq nil
	      (mapcar
	       (lambda (b)
		 (and (buffer-name b) b))
	       sl-term-list)))

  ;; move last used buffer to 1st
  ;; (cond ((not (eq (current-buffer)
  ;; 		 (car sl-term-list))))
  ;; 	((> (length sl-term-list) 1)
  ;; 	 (let ((n1 (car sl-term-list))
  ;; 	       (n2 (nth 1 sl-term-list))
  ;; 	       (n3 (nthcdr 2 sl-term-list)))
  ;; 	       (setq sl-term-list
  ;; 		     (append (list n2 n1) n3))))
  ;; 	(t))
      

  (let (buf)
    (setq buf
          (ido-completing-read "Term: "
                               (delq nil
                                     (mapcar
                                      (lambda (b)
                                        (and
                                         (not (eq b (current-buffer)))
                                         (buffer-name b)))
                                      sl-term-list))))
    (if (get-buffer buf)
	(switch-to-buffer buf)
      (ansi-term
       (or explicit-shell-file-name
	   (getenv "ESHELL")
	   (getenv "SHELL")
	   "/bin/sh")
      (concat "term-" buf)))
   
    ;; move current buffer to 1st of list
    (setq sl-term-list
	  (delq (current-buffer) sl-term-list))
    (add-to-list 'sl-term-list (current-buffer))))


(defun track-shell-directory/procfs ()
  "This has the same goal as ShellDirtrackByPrompt but uses a
different approach. It doesn’t require you to change your shell’s
rc-file."
  (shell-dirtrack-mode 0)
  (add-hook 'comint-preoutput-filter-functions
            (lambda (str)
              (prog1 str
                (when (string-match comint-prompt-regexp str)
                  (cd (file-symlink-p
                       (format "/proc/%s/cwd" (process-id
                                               (get-buffer-process
                                                (current-buffer)))))))))
            nil t))

;(add-hook 'term-mode-hook 'track-shell-directory/procfs)
;(remove-hook 'term-mode-hoook 'track-shell-directory/procfs)
;(setq term-mode-hook nil)