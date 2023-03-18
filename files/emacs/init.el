;;; package --- init.el
;;
;;; Commentary:
;;
;; My Emacs init.el configuration
;; Author: hienpdbk
;;
;;; Code:

;; Package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Define my-key-map
(define-prefix-command 'my-key-map)
(global-set-key (kbd "C-SPC") 'my-key-map)

;; Packages
(use-package which-key
  :init
  (which-key-mode))

(use-package avy)

;; A generic completion mechnism for Emacs
(use-package ivy
  :init
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (ivy-mode))

(use-package counsel
  :init
  (counsel-mode))

;; Alternative for isearch
(use-package swiper)

(use-package go-mode
  :hook (go-mode . lsp))

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-x c")
  :hook (;; if you want which-key integration
       (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package flycheck
  :init (global-flycheck-mode))

(use-package projectile
  :config
  (projectile-mode)
  (setq projectile-project-search-path '(("~/workspace/dac/repos/" . 1))))

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

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

;; ===========================================
;; Init setup
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)
(setq inhibit-startup-message t)    ; Don't show the startup message screen
(setq visible-bell t)               ; Flash when the bell rings
(setq custom-file "~/.emacs.d/custom-file.el")
(load custom-file)
(setq make-backup-files nil)

(setq-default tab-width 4)

;; redefine 'set-mark-command (origin: C-SPC)
(define-key 'my-key-map (kbd "SPC") 'set-mark-command)

;; windmove keybindings
(define-prefix-command 'window)
(define-key 'my-key-map (kbd "w") 'window)
(define-key 'window (kbd "h") 'windmove-left)
(define-key 'window (kbd "l") 'windmove-right)
(define-key 'window (kbd "k") 'windmove-up)
(define-key 'window (kbd "j") 'windmove-down)
(define-key 'window (kbd "i") 'split-window-horizontally)
(define-key 'window (kbd "v") 'split-window-vertically)
(define-key 'window (kbd "d") 'delete-window)

;; terminal key bindings
(define-prefix-command 'terminal)
(define-key 'my-key-map (kbd "t") 'terminal)
(define-key 'terminal (kbd "o") 'term)
(define-key 'terminal (kbd "r") 'counsel-shell-history) ;; for shell

;; magit
(define-prefix-command 'magit)
(define-key 'my-key-map (kbd "g") 'magit)
(define-key 'magit (kbd "g") 'magit-status)

;; projectile
(define-key 'my-key-map (kbd "p") 'projectile-command-map)

;; buffer
(define-prefix-command 'buffer)
(define-key 'my-key-map (kbd "b") 'buffer)
(define-key 'buffer (kbd "b") 'switch-to-buffer)
(define-key 'buffer (kbd "s") 'save-buffer)
(define-key 'buffer (kbd "k") 'kill-buffer)
(define-key 'buffer (kbd "c") 'avy-goto-char-2)

;; search
(define-prefix-command 'search)
(define-key 'my-key-map (kbd "s") 'search)
(define-key 'search (kbd "s") 'swiper)

(provide 'init)
;;; init.el ends here

;; TODO:
;; 1. fix lsp key prefix
;; 2. fuzzy search within project
;; 3. debugger
;; 4. show git status inline within buffer
