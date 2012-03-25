;; sdcv in eamcs
;; author: pluskid
;; 调用 stardict 的命令行程序 sdcv 来查辞典
;; 如果选中了 region 就查询 region 的内容，否则查询当前光标所在的单词
;; 查询结果在一个叫做 *sdcv* 的 buffer 里面显示出来，在这个 buffer 里面
;; 按 q 可以把这个 buffer 放到 buffer 列表末尾，按 d 可以查询单词
(global-set-key (kbd "C-c d") 'wd-dict-to-buffer)
(defun kid-sdcv-to-buffer ()
  (interactive)
  (let ((word (if mark-active
                  (buffer-substring-no-properties (region-beginning) (region-end))
                  (current-word nil t))))
    (setq word (read-string (format "Search the dictionary for (default %s): " word)
                            nil nil word))
    (set-buffer (get-buffer-create "*sdcv*"))
    (buffer-disable-undo)
    (erase-buffer)
    (let ((process (start-process-shell-command "sdcv" "*sdcv*" "sdcv -u '朗道英汉字典5.0'" "-n" word)))
      (set-process-sentinel
       process
       (lambda (process signal)
         (when (memq (process-status process) '(exit signal))
           (unless (string= (buffer-name) "*sdcv*")
             (setq kid-sdcv-window-configuration (current-window-configuration))
             (switch-to-buffer-other-window "*sdcv*")
             (local-set-key (kbd "d") 'kid-sdcv-to-buffer)
             (local-set-key (kbd "q") (lambda ()
                                        (interactive)
                                        (bury-buffer)
                                        (unless (null (cdr (window-list))) ; only one window
                                          (delete-window)))))
           (goto-char (point-min))))))))

(defun wd-dict-filter (proc result)
" 解析返回的 json 数据，拼接结果，插入到 proc 对应的 buffer "
  (with-current-buffer (process-buffer proc)
    (let ((moving (= (point) (process-mark proc)))
          (n 0)
          (dict-result "")
          (dict-body (cdr 
                      (assq 'entries 
                            (assq 'smartResult 
                                  (json-read-from-string result))))))
      (while (< n (length dict-body))
        (setq dict-result (concat dict-result (concat "  " (aref dict-body n)) "\n"))
        (setq n (+ n 1))
        )
      
      (save-excursion
        ;; Insert the text, advancing the process marker.
        (goto-char (process-mark proc))
        (insert dict-result)
        (set-marker (process-mark proc) (point)))
      (if moving (goto-char (process-mark proc))))))

(defun wd-dict-to-buffer ()
  (interactive)
  (let ((word (if mark-active
                  (buffer-substring-no-properties (region-beginning) (region-end))
                  (current-word nil t))))
    (setq word (read-string (format "Search the dictionary for (default %s): " word)
                            nil nil word))
    (set-buffer (get-buffer-create "*sdcv*"))
    (buffer-disable-undo)
    (erase-buffer)
    (insert (format "%s:\n" word))
    (let ((process (start-process-shell-command "curl" "*sdcv*" (format (concat "curl -s " "\'http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule&smartresult=ugc&sessionFrom=null&doctype=json&flag=false&i=%s&keyfrom=fanyi.web&type=AUTO&typoResult=true&ue=UTF-8&xmlVersion=1.4\'" ) word))))
      (set-process-filter process 'wd-dict-filter)
      (set-process-sentinel
       process
       (lambda (process signal)
         (when (memq (process-status process) '(exit signal))
           (unless (string= (buffer-name) "*sdcv*")
             (setq kid-sdcv-window-configuration (current-window-configuration))
             (switch-to-buffer-other-window "*sdcv*")
             (local-set-key (kbd "d") 'wd-dict-to-buffer)
             (local-set-key (kbd "q") (lambda ()
                                        (interactive)
                                        (bury-buffer)
                                        (unless (null (cdr (window-list))) ; only one window
                                          (delete-window)))))
           (goto-char (point-min))))))))


(require 'json)

(json-read-string 



(provide 'wd-dict)
