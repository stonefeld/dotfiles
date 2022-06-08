;; no starup page
(setq inhibit-startup-message t)

;; disable gui items
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; ignore any visual error
(setq ring-bell-function 'ignore)

;; scroll settings
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq redisplay-dont-pause t)
(setq scroll-margin 1)
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq scroll-preserver-screen-position 1)

;; disable file backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; wrap line by word and highlight current line
(global-visual-line-mode)
(global-hl-line-mode)

;; don't show line highlight when pressing ctrl+space
(setq-default transient-mark-mode nil)

;; scroll on compilation pane
(setq compilation-scroll-output t)

;; define a function to copy the whole line
(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
		  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

;; find-file but avoid changing default directory
(defun find-file-save-directory ()
  "Find files but avoid changing default-directory variable"
  (interactive)
  (setq saved-default-directory default-directory)
  (ido-find-file)
  (setq default-directory saved-default-directory))
(defun find-file-save-directory-other-window ()
  "Find files on other window but avoid changing default-directory variable"
  (interactive)
  (setq saved-default-directory default-directory)
  (ido-find-file-other-window)
  (setq default-directory saved-default-directory))

;; unbind some default bindings
(global-unset-key "\C-x")
(global-unset-key "\C-c")
(global-unset-key "\C-z")
(global-unset-key "\C-y")
(global-unset-key "\C-w")
(global-unset-key "\M-w")
(global-unset-key "\M-/")

;; bind keys
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-y") 'undo-redo)
(global-set-key (kbd "C-c") 'kill-ring-save)
(global-set-key (kbd "C-S-c") 'copy-line)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-x") 'kill-region)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-S-s") (lambda () (interactive) (save-some-buffers "!")))
(global-set-key (kbd "C-f") 'isearch-forward)
(global-set-key (kbd "C-S-f") 'isearch-backward)
(global-set-key (kbd "C-d") 'delete-region)
(global-set-key (kbd "C-S-d") 'kill-whole-line)
(global-set-key (kbd "M-m") (lambda () (interactive) (if (file-exists-p "build.bat") (compile "build.bat") (if (file-exists-p "build.sh") (compile "build.sh") (call-interactively 'compile)))))
(global-set-key (kbd "<f1>") 'recompile)
(global-set-key (kbd "C-o") 'find-file-save-directory)
(global-set-key (kbd "C-S-o") 'find-file-save-directory-other-window)
(global-set-key (kbd "C-,") 'other-window)
(global-set-key (kbd "C-k") 'kill-buffer)
(global-set-key (kbd "C-S-k") (lambda () (interactive) (kill-buffer (current-buffer))))
(global-set-key (kbd "C-i") 'switch-to-buffer)
(global-set-key (kbd "C-S-i") 'switch-to-buffer-other-window)
(global-set-key (kbd "C-w") 'imenu)

;; create a minor mode to change some important keys
(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<tab>") 'dabbrev-expand)
    (define-key map (kbd "<backtab>") 'undo)
    (define-key map (kbd "C-<tab>") 'indent-for-tab-command)
    map)
  "my-keys-minor-mode-map keymap.")

;; activate the minor mode
(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying mayor modes."
  :init-value 1)
(my-keys-minor-mode 1)

;; avoid changing important keys on the minibuffer
(add-hook 'minibuffer-setup-hook (lambda () (my-keys-minor-mode 0)))

;; change default appereance
(set-face-attribute 'default t :font "Liberation Mono-11" :foreground "burlywood3" :background "gray10")
(set-face-attribute 'cursor nil :background "green")
(set-face-attribute 'hl-line nil :background "midnight blue")
(set-face-attribute 'region nil :background "dark blue")
(set-face-attribute 'font-lock-warning-face nil :foreground "red")
(set-face-attribute 'font-lock-function-name-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-keyword-face nil :foreground "DarkGoldenrod3")
(set-face-attribute 'font-lock-comment-face nil :foreground "gray40")
(set-face-attribute 'font-lock-type-face nil :foreground "DarkGoldenrod3")
(set-face-attribute 'font-lock-constant-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-builtin-face nil :foreground "burlywood3")
(set-face-attribute 'font-lock-string-face nil :foreground "olive drab")
(set-face-attribute 'font-lock-preprocessor-face nil :foreground "khaki")
(set-face-attribute 'font-lock-doc-face nil :foreground "olive drab")

;; set some default c-style settings
(setq c-default-style "linux"
      c-basic-offset 4)
(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'brace-list-open 0)
  (c-set-offset 'case-label '+)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'access-label '-)
  (c-toggle-hungry-state 1)
  (font-lock-add-keywords nil '(("\\<\\(FIXME\\|TODO\\|NOTE\\|BUG\\|BUGFIX\\)[(:]" 1 font-lock-warning-face t)))
  (font-lock-add-keywords nil '(("\\<\\(true\\|false\\|\\(0[xb]\\)?[0-9]+\\.?[0-9]+[fFlL]?\\)" 1 font-lock-string-face t))))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; startup hook
(add-hook 'after-init-hook (lambda () (split-window-right)))
