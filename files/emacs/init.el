;;; package --- init.el
;;
;;; Commentary:
;; My Emacs init.el configuration
;; Author: hienpdbk
;;
;; Dependency:
;;   ripgrep                     (for projectile-ripgrep)
;;   gopls                       (for lsp-mode go)
;;   delve                       (for dap-mode)
;;
;;; Code:
(setq gc-cons-threshold (* 50 1000 1000))

;; ==================================================
;; PACKAGE MANAGER
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ================================================
;; my-key-map
; (define-prefix-command 'my-key-map)
(defvar my-keymap (make-sparse-keymap))
(define-key global-map (kbd "C-SPC") (cons "my-prefix" my-keymap))

;; =================================================
;; PACKAGES
(use-package which-key
  :init
  (which-key-mode))

(use-package avy)

;; A generic completion mechnism for Emacs
(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
		'((t . ivy--regex-ignore-order)))
  (ivy-mode))

(use-package counsel
  :init
  (counsel-mode))

;; Alternative for isearch
(use-package swiper)

(use-package company
  :init
  (global-company-mode))

;; TODO: to be removed (review time)
;;(use-package consult)

(use-package go-mode)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-SPC c")
  :hook (;; if you want which-key integration
		 (sh-mode . lsp)
		 (c++-mode . lsp)
		 (c-mode . lsp)
		 (go-mode . lsp)
		 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)

;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;; (use-package dap-mode
;;   :after lsp-mode
;;   :config
;;   ;; (dap-mode 1)
;;   (dap-auto-configure-mode 1)
;;   (require 'dap-dlv-go)
;;   :custom
;;   (dap-auto-configure-features '(sessions locals breakpoints expressions repl controls tooltip)))

;; (use-package dap-LANGUAGE) to load the dap adapter for your language

(use-package flycheck
  :init (global-flycheck-mode))

(use-package projectile
  :config
  (projectile-mode)
  (setq projectile-project-search-path '(("~/workspace/repos/" . 1) ("~/vm-cfg" . 0))))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package treemacs
  :config
  (treemacs-project-follow-mode))

(use-package magit)

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t))

(use-package rg)

(use-package git-gutter
  :init (global-git-gutter-mode))

;; ===========================================
;; UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq column-number-mode t)
(global-display-line-numbers-mode 1)
(setq-default display-line-numbers-type 'relative)
(global-hl-line-mode 1)

(electric-pair-mode 1)

(setq inhibit-startup-message t)    ; Don't show the startup message screen
(setq visible-bell t)               ; Flash when the bell rings
(setq custom-file "~/.emacs.d/custom-file.el")
(load custom-file 'noerror)
(setq make-backup-files nil)
(setq confirm-kill-emacs 'y-or-n-p)
(setq-default tab-width 4)
;; Revert (update) buffers automatically when underlying files are changed externally.
(global-auto-revert-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook
                vterm-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; start every frame maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; ===========================================
;; KEY BINDINGS

;; redefine 'set-mark-command (origin: C-SPC)
(defvar my-mark-map (make-sparse-keymap))
(define-key my-keymap (kbd "m") (cons "mark" my-mark-map))
(define-key my-mark-map (kbd "m") '("set-mark-command" . set-mark-command))
(define-key my-mark-map (kbd "p") '("pop-global-mark" . pop-global-mark))

;; terminal
(defvar my-terminal-map (make-sparse-keymap))
(define-key my-keymap (kbd "t") (cons "terminal" my-terminal-map))
(define-key my-terminal-map (kbd "o") '("open-term" . term))
(define-key my-terminal-map (kbd "r") '("search-history" . counsel-shell-history))

;; magit
(defvar my-magit-map (make-sparse-keymap))
(define-key my-keymap (kbd "g") (cons "magit" my-magit-map))
(define-key my-magit-map (kbd "g") '("status" . magit-status))

;; project
(define-key my-keymap (kbd "p") (cons "projectile" projectile-command-map))
(define-key projectile-command-map (kbd "t") '("treemacs-toggle" . treemacs)) ;; project directory tree
(define-key projectile-command-map (kbd "r") '("rg-text" . counsel-rg))             ;; ripgrep text in project

;; code
(define-key global-map (kbd "C-SPC c e") '("error-list" . counsel-flycheck))
(define-key global-map (kbd "C-SPC c c") '("comment-line" . comment-line))

;; window
(defvar my-window-map (make-sparse-keymap))
(define-key my-keymap (kbd "w") (cons "wiwndow" my-window-map))
(define-key my-window-map (kbd "h") '("windmove-left" . windmove-left))
(define-key my-window-map (kbd "l") '("windmove-right" . windmove-right))
(define-key my-window-map (kbd "k") '("windmove-up" . windmove-up))
(define-key my-window-map (kbd "j") '("windmove-down" . windmove-down))
(define-key my-window-map (kbd "i") '("split-window-horizontally" . split-window-horizontally))
(define-key my-window-map (kbd "v") '("split-window-vertically" . split-window-vertically))
(define-key my-window-map (kbd "d") '("delete-window" . delete-window))

;; buffer
(defvar my-buffer-map (make-sparse-keymap))
(define-key my-keymap (kbd "b") (cons "buffer" my-buffer-map))
(define-key my-buffer-map (kbd "b") '("switch-to-buffer" . switch-to-buffer))
(define-key my-buffer-map (kbd "s") '("save-buffer" . save-buffer))
(define-key my-buffer-map (kbd "k") '("kill-buffer" . kill-buffer))
(define-key my-buffer-map (kbd "f") '("find-file" . find-file))

;; search
(defvar my-search-map (make-sparse-keymap))
(define-key my-keymap (kbd "s") (cons "search" my-search-map))
(define-key my-search-map (kbd "s") '("in-buffer" . swiper))
(define-key my-search-map (kbd "c") '("avy-goto-char-2" . avy-goto-char-2))

;; emacs
(defvar my-emacs-map (make-sparse-keymap))
(define-key my-keymap (kbd "e") (cons "emacs" my-emacs-map))
(define-key my-emacs-map (kbd "q") '("save-buffers-kill-emacs" . save-buffers-kill-emacs))
(define-key my-emacs-map (kbd "s") '("desktop-save" . desktop-save))
(define-key my-emacs-map (kbd "r") '("desktop-read" . desktop-read))

;; register
(define-key my-keymap (kbd "r") (cons "register" ctl-x-r-map))
(define-key ctl-x-r-map (kbd "v") '("view-register". view-register))

;; common
(define-key my-keymap (kbd "x") '("M-x" . execute-extended-command))
(define-key my-keymap (kbd "h") (cons "help" help-map))

;; other
(defvar my-other-map (make-sparse-keymap))
(define-key my-keymap (kbd "o") (cons "other" my-other-map))
;;    tab-bar
(setq tab-bar-show nil)
(define-key my-other-map (kbd "n") '("new-tab-bar" . tab-bar-new-tab))
(define-key my-other-map (kbd "s") '("switch-tab-bar" . tab-bar-switch-to-tab))
(define-key my-other-map (kbd "r") '("rename-tab-bar" . tab-bar-rename-tab))
(define-key my-other-map (kbd "c") '("close-tab-bar" . tab-bar-close-tab))

;;    clipboard
(define-key my-other-map (kbd "y") '("clipboard-kill-ring-save" . clipboard-kill-ring-save))
(define-key my-other-map (kbd "p") '("clipboard-yank" . clipboard-yank))

(setq gc-cons-threshold (* 2 1000 1000))

(provide 'init)
;;; init.el ends here
