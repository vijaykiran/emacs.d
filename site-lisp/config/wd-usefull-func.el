;; ;; vim % command
;; (defun match-paren (arg)
;;   "Go to the matching paren if on a paren; otherwise insert %."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;; 	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;; 	(t (self-insert-command (or arg 1)))))

;; (global-set-key (kbd "C-%") 'match-paren)

;; C-s C-f 搜索光标当前的词
(define-key isearch-mode-map (kbd "C-f") 
  '(lambda ()
     (interactive)
     (save-excursion
       (re-search-backward "[^[:alnum:]-_@.]" nil t)
       (forward-char)
       (isearch-yank-internal
        (lambda ()
        (re-search-forward "[[:alnum:]-_@.]*[[:alnum:]]" nil t))))))

(defun sl-mark-symbol ()
  (interactive)
  (re-search-backward "[^[:alnum:]-_@.]" nil t)
  (forward-char)
  (set-mark (point))
  (goto-char
   (re-search-forward "[[:alnum:]-_@.]*[[:alnum:]]" nil t)))

;; M-w 复制一行，如果有选中，就复制选中的内容
(defun huangq-kill-ring-save (&optional n)
  "If region is active, copy region. Otherwise, copy line."
  (interactive "p")
  (if mark-active
      (kill-ring-save (region-beginning) (region-end))
    (if (> n 0)
        (kill-ring-save (line-beginning-position) (line-end-position n))
      (kill-ring-save (line-beginning-position n) (line-end-position)))))

(global-set-key (kbd "M-w") 'huangq-kill-ring-save)

;; C-c w 复制一个单词
(defun huangq-save-word-at-point()
  (interactive)
  (save-excursion
    (let ((end (progn (unless (looking-back "\\>" 1) (forward-word 1)) (point)))
          (beg (progn (forward-word -1) (point))))
      (copy-region-as-kill beg end)
      (message (substring-no-properties (current-kill 0))))))

(global-set-key (kbd "C-c w") 'huangq-save-word-at-point)

;; swap window
(setq swapping-buffer nil)
(setq swapping-window nil)

(defun swap-buffers-in-windows ()
   "Swap buffers between two windows"
   (interactive)
   (if (and swapping-window
            swapping-buffer)
       (let ((this-buffer (current-buffer))
             (this-window (selected-window)))
         (if (and (window-live-p swapping-window)
                  (buffer-live-p swapping-buffer))
             (progn (switch-to-buffer swapping-buffer)
                    (select-window swapping-window)
                    (switch-to-buffer this-buffer)
                    (select-window this-window)
                    (message "Swapped buffers."))
           (message "Old buffer/window killed.  Aborting."))
         (setq swapping-buffer nil)
         (setq swapping-window nil))
     (progn
       (setq swapping-buffer (current-buffer))
       (setq swapping-window (selected-window))
       (message "Buffer and window marked for swapping."))))

(global-set-key (kbd "C-c p") 'swap-buffers-in-windows)

;; auto close compile message window
(setq xwl-layout-before-compilation nil)
(eval-after-load 'compile
  '(progn
     (message "compile start")
     (defadvice compile (before save-layout activate)
       (setq xwl-layout-before-compilation (current-window-configuration)))))

(defun xwl-compilation-exit-autoclose (status code msg)
  (if (not (and (eq status 'exit) (zerop code)))
      (message "Compilation failed")
    (run-at-time 3 nil (lambda ()
                         (set-window-configuration xwl-layout-before-compilation)))
    (message "Compilation succeed"))
  (cons msg code))

(setq compilation-exit-message-function 'xwl-compilation-exit-autoclose)

(defun auto-complete-mode-maybe ()
  "What buffer `auto-complete-mode' prefers."
  (if (and (not (minibufferp (current-buffer)))
           ;; xwl: Enable for all mode.
           ;; (memq major-mode ac-modes)
           )
      (auto-complete-mode 1)))

(auto-complete-mode-maybe)

;; tray notify
(defun wd-send-tray-notify (icon title message)
    (let ((default-directory "~/"))
      ;; (start-process "page-me" nil "kdialog" "--title" title  "--passivepopup" message "60")))
      (start-process "page-me" nil "/usr/bin/notify-send" "-i" icon title message)))


; ================================
;;  % for paren match
;; ================================
;; (global-set-key "%" 'match-paren)

(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

(global-set-key (kbd "C-%") 'goto-match-paren)

;;
;; 使用 C-. 标记， C-, 切换
;;

(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp)))


;; highlight TODO, FIXME, BUG kw
(defface sl-highlight-todo-face
  '((t :weight bold
       :foreground "red"
       :background "yellow"))
  "Highlight Todo")

(defvar sl-highlight-todo-keywords "\\<\\(FIXME\\|TODO\\|BUG\\):")
(defun sl-highlight-todo ()
   (font-lock-add-keywords
    nil
    `((,sl-highlight-todo-keywords
       1 'sl-highlight-todo-face t))))

(defun sl-list-todo ()
  (interactive)
  (occur sl-highlight-todo-keywords))

(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))
(global-set-key "\M-Y" 'yank-pop-forwards) ; M-Y (Meta-Shift-Y)

(defadvice show-paren-function
  (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
        echo area. Has no effect if the character before point is not of
        the syntax class ')'."
  (interactive)
  (if (not (minibuffer-prompt))
      (let ((matching-text nil))
        ;; Only call `blink-matching-open' if the character before point
        ;; is a close parentheses type character. Otherwise, there's not
        ;; really any point, and `blink-matching-open' would just echo
        ;; "Mismatched parentheses", which gets really annoying.
        (if (char-equal (char-syntax (char-before (point))) ?\))
            (setq matching-text (blink-matching-open)))
        (if (not (null matching-text))
            (message matching-text)))))



(provide 'wd-usefull-func)
