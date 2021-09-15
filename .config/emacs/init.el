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
(setq scroll-step 1)

;; Set up visible bell
(setq visible-bell t)

;; Set default tab size to 4
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)

;; Disable file backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Initialize packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Change default appereance
(setq default-frame-alist
	  '((font . "-*-Liberation Mono-normal-r-*-*-15-*-*-*-c-*-iso8859-1")
		(cursor-color . "DarkOrange")))

;; Load gruvbox theme
(load-theme 'gruvbox-dark-medium t)

;; Set default compile command
(setq compilation-scroll-output t)

;; Keybindings
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-s") 'save-buffer)
	(define-key map (kbd "C-o") 'find-file)
	(define-key map (kbd "C-S-o") 'find-file-other-window)
	(define-key map (kbd "C-p") 'switch-to-buffer)
	(define-key map (kbd "C-S-p") 'switch-to-buffer-other-window)
	(define-key map (kbd "C-,") 'other-window)
	(define-key map (kbd "C-k") 'kill-buffer)
	(define-key map (kbd "C-f") 'isearch-forward)
	(define-key map (kbd "C-d") 'delete-region)
	(define-key map (kbd "C-S-d") 'kill-whole-line)
	(define-key map (kbd "C-z") 'undo)
	(define-key map (kbd "C-c") 'kill-ring-save)
	(define-key map (kbd "C-x") 'kill-region)
	(define-key map (kbd "C-v") 'clipboard-yank)
	(define-key map (kbd "M-<f4>") 'kill-emacs)
	(define-key map (kbd "<f1>") 'recompile)
	(define-key map (kbd "M-m") (lambda () (interactive) (if (file-exists-p "build.bat") (compile "build.bat") (if (file-exists-p "build.sh") (compile "build.sh") (call-interactively 'compile)))))
	map)
  "my-keys-minor-mode keymap.")

;; Override any annoying mayor modes
(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying mayor modes."
  :init-value t
  :lighter "")
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

;; Avoid weird indentation on c and c++ code
(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; Avoid changing default-directory value when using find-file command
(setq current-working-directory default-directory)
(add-hook 'find-file-hook #'(lambda () (setq default-directory (expand-file-name current-working-directory))))

;; Init commands
(split-window-right)
(switch-to-buffer-other-window "*Messages*")
(switch-to-buffer-other-window "*scratch*")
(setq-default transient-mark-mode nil)
(setq-default truncate-lines t)
