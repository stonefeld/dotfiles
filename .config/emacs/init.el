;; no startup page
(setq inhibit-startup-message t)

;; disable graphical things
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)

;; scroll settings
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq redisplay-dont-pause t)
(setq scroll-margin 1)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq scroll-preserver-screen-position 1)

;; enable visible bell
(setq visible-bell t)
(setq-default transient-mark-mode nil)
(setq-default truncate-lines t)

;; set default tab size to 4
(setq-default tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)

;; disable file backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; change default appereance
(add-to-list 'default-frame-alist '(font . "Liberation Mono-11"))
(set-face-attribute 'default t :font "Liberation Mono-11" :foreground "burlywood3" :background "#161616")
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

;; scroll on compilation pane
(setq compilation-scroll-output t)

;; ;; keybindings
;; (defvar my-keys-minor-mode-map
;;   (let ((map (make-sparse-keymap)))
;; 	(define-key map (kbd "C-s") 'save-buffer)
;; 	(define-key map (kbd "C-S-s") (lambda () (interactive) (save-some-buffers "!")))
;; 	(define-key map (kbd "C-o") 'find-file)
;; 	(define-key map (kbd "C-S-o") 'find-file-other-window)
;; 	(define-key map (kbd "C-p") 'switch-to-buffer)
;; 	(define-key map (kbd "C-S-p") 'switch-to-buffer-other-window)
;; 	(define-key map (kbd "C-,") 'other-window)
;; 	(define-key map (kbd "C-.") 'exchange-point-and-mark)
;; 	(define-key map (kbd "C-k") 'kill-buffer)
;; 	(define-key map (kbd "C-S-k") (lambda () (interactive) (kill-buffer (current-buffer))))
;; 	(define-key map (kbd "C-f") 'isearch-forward)
;; 	(define-key map (kbd "C-d") 'delete-region)
;; 	(define-key map (kbd "C-S-d") 'kill-whole-line)
;; 	(define-key map (kbd "C-<backspace>") 'my-backward-kill-word)
;; 	(define-key map (kbd "C-z") 'undo)
;; 	(define-key map (kbd "C-c") 'kill-ring-save)
;; 	(define-key map (kbd "C-x") 'kill-region)
;; 	(define-key map (kbd "C-v") 'clipboard-yank)
;; 	(define-key map (kbd "<tab>") 'dabbrev-expand)
;; 	(define-key map (kbd "C-<tab>") 'indent-for-tab-command)
;; 	(define-key map (kbd "C-S-<tab>") 'indent-region)
;; 	(define-key map (kbd "M-m") (lambda () (interactive) (if (file-exists-p "build.bat") (compile "build.bat") (if (file-exists-p "build.sh") (compile "build.sh") (call-interactively 'compile)))))
;; 	(define-key map (kbd "<f1>") 'recompile)
;; 	(define-key map (kbd "M-<f4>") 'kill-emacs)
;; 	map)
;;   "my-keys-minor-mode keymap.")
;;
;; ;; override any annoying mayor modes
;; (define-minor-mode my-keys-minor-mode
;;   "A minor mode so that my key settings override annoying mayor modes."
;;   :init-value t)
;; (my-keys-minor-mode 1)
;;
;; ;; disable the minor mode on the minibuffer
;; (defun my-minibuffer-setup-hook ()
;;   (my-keys-minor-mode 0))
;; (add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

;; add standard c and c++ styles as well as some comment keywords highlight
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

;; detect .h files as C++ header files by default
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; avoid changing default-directory value when using find-file command
(setq current-working-directory default-directory)
(add-hook 'find-file-hook #'(lambda () (setq default-directory (expand-file-name current-working-directory))))

;; initialize packages
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("org" . "https://ormode.org/elpa/")
        ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; ensure all required packages are installed
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; vim like keybindings.
(use-package undo-fu)
(use-package evil
      :demand t
      :bind (("<escape>" . keyboard-escape-quit))
      :init
      (setq evil-search-module 'evil-search)
      (setq evil-want-keybinding nil)
      (setq evil-undo-system 'undo-fu)
      :config
      (evil-mode 1))
(use-package evil-collection
      :after evil
      :config
      (setq evil-want-integration t)
      (evil-collection-init))

;; Init commands
(electric-pair-mode)
(split-window-right)
