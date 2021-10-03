;; No startup page
(setq inhibit-startup-message t)

;; Disable scroll-bar, tool-bar, menu-bar and tool-tip
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)

;; Scroll settings    
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)    
(setq mouse-wheel-follow-mouse 't)    
(setq redisplay-dont-pause t)
(setq scroll-margin 1)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq scroll-preserver-screen-position 1)

;; Set up visible bell, disable visual selection on ctrl+space and avoid linewrapping
(setq visible-bell t)
(setq-default transient-mark-mode nil)
(setq-default truncate-lines t)

;; Set default tab size to 4
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)

;; Disable file backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Change default appereance
(add-to-list 'default-frame-alist '(font . "Liberation Mono-9"))
(set-face-attribute 'default t :font "Liberation Mono-9" :foreground "burlywood3" :background "#161616")
(set-face-attribute 'cursor nil :background "green")
(set-face-attribute 'font-lock-warning-face nil :foreground "red")
(set-face-attribute 'font-lock-function-name-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-keyword-face nil :foreground "DarkGoldenrod3")
(set-face-attribute 'font-lock-comment-face nil :foreground "dim gray")
(set-face-attribute 'font-lock-type-face nil :foreground "DarkGoldenrod3")
(set-face-attribute 'font-lock-constant-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-builtin-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-string-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-preprocessor-face nil :foreground "khaki")
(set-face-attribute 'font-lock-doc-face nil :foreground "green" :weight 'bold)

;; Set default compile command
(setq compilation-scroll-output t)

;; Keybindings
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-s") 'save-buffer)
	(define-key map (kbd "C-S-s") (lambda () (interactive) (save-some-buffers "!")))
	(define-key map (kbd "C-o") 'find-file)
	(define-key map (kbd "C-S-o") 'find-file-other-window)
	(define-key map (kbd "C-p") 'switch-to-buffer)
	(define-key map (kbd "C-S-p") 'switch-to-buffer-other-window)
	(define-key map (kbd "C-,") 'other-window)
	(define-key map (kbd "C-.") 'exchange-point-and-mark)
	(define-key map (kbd "C-k") 'kill-buffer)
	(define-key map (kbd "C-S-k") (lambda () (interactive) (kill-buffer (current-buffer))))
	(define-key map (kbd "C-f") 'isearch-forward)
	(define-key map (kbd "C-d") 'delete-region)
	(define-key map (kbd "C-S-d") 'kill-whole-line)
	(define-key map (kbd "C-<backspace>") 'my-backward-kill-word)
	(define-key map (kbd "C-z") 'undo)
	(define-key map (kbd "C-c") 'kill-ring-save)
	(define-key map (kbd "C-x") 'kill-region)
	(define-key map (kbd "C-v") 'clipboard-yank)
	(define-key map (kbd "<tab>") 'dabbrev-expand)
	(define-key map (kbd "C-<tab>") 'indent-for-tab-command)
	(define-key map (kbd "C-S-<tab>") 'indent-region)
	(define-key map (kbd "M-m") (lambda () (interactive) (if (file-exists-p "build.bat") (compile "build.bat") (if (file-exists-p "build.sh") (compile "build.sh") (call-interactively 'compile)))))
	(define-key map (kbd "<f1>") 'recompile)
	(define-key map (kbd "M-<f4>") 'kill-emacs)
	map)
  "my-keys-minor-mode keymap.")

;; Override any annoying mayor modes
(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying mayor modes."
  :init-value t)
(my-keys-minor-mode 1)

;; Disable the minor mode on the minibuffer
(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))
(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

;; Enable smarttabs
(defadvice align (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice align-regexp (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice indent-relative (around smart-tabs activate)
  (let ((indent-tabs-mode nil)) ad-do-it))
(defadvice indent-according-to-mode (around smart-tabs activate)
  (let ((indent-tabs-mode indent-tabs-mode))
    (if (memq indent-line-function
			  '(indent-relative
				indent-relative-maybe))
		(setq indent-tabs-mode nil))
	ad-do-it))
(defmacro smart-tabs-advice (function offset)
  `(progn
	 (defvaralias ',offset 'tab-width)
	 (defadvice ,function (around smart-tabs activate)
	   (cond
		(indent-tabs-mode
		 (save-excursion
		   (beginning-of-line)
		   (while (looking-at "\t*\\( +\\)\t+")
			 (replace-match "" nil nil nil 1)))
		 (setq tab-width tab-width)
		 (let ((tab-width fill-column)
			   (,offset fill-column)
			   (wstart (window-start)))
		   (unwind-protect
			   (progn ad-do-it)
			 (set-window-start (selected-window) wstart))))
		(t
		 ad-do-it)))))
(smart-tabs-advice c-indent-line c-basic-offset)
(smart-tabs-advice c-indent-region c-basic-offset)
(provide 'smarttabs)

;; Avoid deleting too large amounts of text on ctrl+backspace
(defun my-backward-kill-word ()
  (interactive)
  (cond
   ((looking-back (rx (char word)) 1)
	(backward-kill-word 1))
   ((looking-back (rx (char blank)) 1)
	(delete-horizontal-space t))
   (t
	(backward-delete-char 1))))

;; Add standard c and c++ styles as well as some comment keywords highlight
(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'case-label '+)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'access-label '-)
  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\)[(:]" 1 font-lock-warning-face t)))
  (font-lock-add-keywords nil '(("\\<\\(NOTE\\)[(:]" 1 font-lock-doc-face t)))
  (font-lock-add-keywords nil '(("\\<\\(true\\|false\\|[0-9]+\\)" 1 font-lock-string-face t))))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; Detect .h files as C++ header files by default
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Avoid changing default-directory value when using find-file command
(setq current-working-directory default-directory)
(add-hook 'find-file-hook #'(lambda () (setq default-directory (expand-file-name current-working-directory))))

;; Init commands
(electric-pair-mode)
(split-window-right)
