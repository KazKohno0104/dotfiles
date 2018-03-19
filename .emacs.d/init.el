;;
;; python
;; 
;;; 自動インデント
(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "\C-m") 'newline-and-indent)
            (define-key python-mode-map (kbd "RET") 'newline-and-indent)))


;;; yasnippet
(add-to-list 'load-path
	(expand-file-name "~/.emacs.d/elpa/yasnippet-20170808.940"))
(require 'yasnippet)
(yas-global-mode 1)


;;; flymake
;(require 'tramp-cmds)
;(when (load "flymake" t)
;  (defun flymake-pyflakes-init ()
;     ; Make sure it's not a remote buffer or flymake would not work
;     (when (not (subsetp (list (current-buffer)) (tramp-list-remote-buffers)))
;      (let* ((temp-file (flymake-init-create-temp-buffer-copy
;                         'flymake-create-temp-inplace))
;             (local-file (file-relative-name
;                          temp-file
;                          (file-name-directory buffer-file-name))))
;        (list "pyflakes" (list local-file)))))
;  (add-to-list 'flymake-allowed-file-name-masks
;               '("\\.py\\'" flymake-pyflakes-init)))
; 
;(add-hook 'python-mode-hook
;          (lambda ()
;            (flymake-mode t)))

(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "/home/kazuyoshi/.local/bin/pyflakes"  (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
; show message on mini-buffer
(defun flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))
(add-hook 'post-command-hook 'flymake-show-help)



;;; autopep8
(add-to-list 'load-path
	(expand-file-name "~/.emacs.d/elpa/py-autopep8-20160925.352"))
(require 'py-autopep8)
;(define-key python-mode-map (kbd "C-c F") 'py-autopep8)  ; バッファ全体のコード整形
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)


;; load-path
;; Remark: 同じpathを複数回appendすると重複が発生する
(setq load-path
      (append (list nil "/usr/share/emacs24/site-lisp/ddskk")
              load-path))

;; SKK
(require 'skk-autoloads) ; XEmacs でパッケージとしてインストールした場合は不要
(global-set-key "\C-x\C-j" 'skk-mode)
(global-set-key "\C-xj" 'skk-auto-fill-mode)
(global-set-key "\C-xt" 'skk-tutorial)
;(setq skk-large-jisyo "/usr/share/skk/SKK-JISYO")
;;; (toggle-input-method nil)


;; fill-column
;; 自動詰め込み、折り返し
(setq-default fill-column 80)




;; package.elの設定
(require 'package)
(setq package-archives
      (append '(("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa" . "http://melpa.milkbox.net/packages/"))
              package-archives))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ddskk markdown-mode yasnippet-bundle yasnippet py-yapf py-autopep8 flymake-python-pyflakes flymake-cursor flymake))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;; markdown-mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.txt" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
