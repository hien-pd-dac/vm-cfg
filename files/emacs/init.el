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

(use-package exec-path-from-shell
  :init
  (when (memq window-system '(mac ns x))
	(exec-path-from-shell-initialize)))

(use-package which-key
  :init
  (which-key-mode))

(use-package avy)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-SPC l")

  :hook (
		 (lsp-mode . lsp-enable-which-key-integration))
  :config
  (add-hook 'before-save-hook 'lsp-format-buffer)
  :commands lsp)

;; (setq completion-styles '(
;; 						  basic
;; 						  partial-completion
;; 						  emacs22
;; 						  ;; flex
;; 						  ))

(setq completion-ignore-case t)

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-prefix 0)          ;; Minimum length of prefix for auto completion
  (corfu-auto-delay 0.0)
  (corfu-popupinfo-delay 0.25)
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match 'separator)      ;; Never quit, even if there is no match
  (corfu-preview-current 'insert)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since Dabbrev can be used globally (M-/).
  ;; See also `corfu-exclude-modes'.
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode))

;; NOTE: about some useful key bindings of Corfu
;;   - C-v, M-v: scroll down, up of candidates
;;   - C-M-v, C-M-S-v: scroll down, up of docstring (popupinfo)

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
  ;; Corfu commands are hidden, since they are not supposed to be used via M-x.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  ;; NOTE: The order matters!
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
;; (use-package emacs
;;   :init
;;   ;; Add prompt indicator to `completing-read-multiple'.
;;   ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
;;   (defun crm-indicator (args)
;;     (cons (format "[CRM%s] %s"
;;                   (replace-regexp-in-string
;;                    "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
;;                    crm-separator)
;;                   (car args))
;;           (cdr args)))
;;   (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

;;   ;; Do not allow the cursor in the minibuffer prompt
;;   (setq minibuffer-prompt-properties
;;         '(read-only t cursor-intangible t face minibuffer-prompt))
;;   (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;;   ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
;;   ;; Vertico commands are hidden in normal buffers.
;;   ;; (setq read-extended-command-predicate
;;   ;;       #'command-completion-default-include-p)

;;   ;; Enable recursive minibuffers
;;   (setq enable-recursive-minibuffers t))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be actived in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

;; Example configuration for Consult
(use-package consult
  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; ;; Use `consult-completion-in-region' if Vertico is enabled.
  ;; ;; Otherwise use the default `completion--in-region' function.
  (setq completion-in-region-function
		(lambda (&rest args)
          (apply (if vertico-mode
					 #'consult-completion-in-region
                   #'completion--in-region)
				 args)))

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 3. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
  ;;;; 4. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 5. No project support
  ;; (setq consult-project-function nil)
)

(use-package consult-yasnippet)

;; optionally
(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-sideline-show-diagnostics nil)
  (setq lsp-ui-doc-show-with-mouse nil))

;; if you are ivy user
;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)

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

(use-package yasnippet
  :config
  (yas-global-mode))
(use-package yasnippet-snippets)

(use-package flycheck
  :init (global-flycheck-mode))

;; (use-package projectile
;;   :config
;;   (projectile-mode)
;;   (setq projectile-project-search-path '(("~/workspace/repos/" . 1)))
;;   ;; (define-key my-keymap (kbd "p") (cons "projectile" projectile-command-map))
;;   )

(use-package org
  :config
  (define-key my-keymap (kbd "o") (cons "org" org-mode-map)))

(use-package all-the-icons
  :if (display-graphic-p))
;; after-install: M-x: all-the-icons-install-fonts

(use-package treemacs
  :config
  (treemacs-project-follow-mode))

(use-package magit)

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-moonlight t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; doom-modeline use nerd-icons
(use-package nerd-icons)
(use-package doom-modeline
  :init (doom-modeline-mode 1))
;; after-install: M-x: nerd-icons-install-fonts

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-center-content t))

(use-package rg)

(use-package git-gutter
  :init (global-git-gutter-mode))

(use-package expand-region)

(use-package smartparens
  :init
  (smartparens-global-mode t)
  (require 'smartparens-config))

(use-package project-tab-groups
  :init
  (project-tab-groups-mode))

(use-package multiple-cursors)

(use-package vterm
  :config
  (add-hook 'vterm-mode-hook
			(lambda()
			  (local-unset-key (kbd "C-SPC")))))

;; NOTE: some useful key bindings in vterm
;; "C-c C-t": copy mode
;; "RET": copy mode -> normal mode
;; "C-y": vterm-yank
;; "C-c C-c": send C-c (KILL SIGN) to vterm

;; ----- PROGRAMMING -----
;; Shell
(add-hook 'sh-mode 'lsp)
;; Go
(use-package go-mode
  :config
  (add-hook 'go-mode-hook 'lsp))
;; C/C++
;;;;   LSP
(use-package ccls
  :hook
  ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))
;; Java
(use-package lsp-java
  :config
  (add-hook 'java-mode-hook 'lsp))

;; ===========================================
;; My customization
(defun hpd/duplicate-line()
  "My custom function used to dupplicate the current line.

  Designed to be used globally."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank))

(defun hpd/win-split-and-move-vertically ()
  "Split a window vertically and move into the new window."
  (interactive)
  (split-window-vertically)
  (windmove-down))

(defun hpd/win-split-and-move-horizontally ()
  "Split a window horizontally and move into the new window."
  (interactive)
  (split-window-horizontally)
  (windmove-right))

;; ===========================================
;; UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq column-number-mode t)
(global-display-line-numbers-mode 1)
(setq-default display-line-numbers-type 'relative)
(global-hl-line-mode 1)
;; never recenters the cursor.
(setq scroll-conservatively 101)

;; (electric-pair-mode 1)

(setq inhibit-startup-message t)    ; Don't show the startup message screen
(setq visible-bell t)               ; Flash when the bell rings
(setq custom-file "~/.emacs.d/custom-file.el")
(load custom-file 'noerror)
(setq make-backup-files nil)
(setq confirm-kill-emacs 'y-or-n-p)
(setq-default tab-width 4)
;; Revert buffers automatically when underlying files are changed externally.
(global-auto-revert-mode t)
;; max line length indicator
(global-display-fill-column-indicator-mode t)
(setq-default display-fill-column-indicator-column 80)

(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-12"))

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

;; mark
(define-key global-map (kbd "C-.") '("set-mark-command" . set-mark-command))
(defvar my-mark-map (make-sparse-keymap))
(define-key my-keymap (kbd "m") (cons "mark" my-mark-map))
(define-key my-mark-map (kbd "m") '("set-mark-command" . set-mark-command))
(define-key my-mark-map (kbd "p") '("pop-global-mark" . pop-global-mark))

;; terminal
(defvar my-terminal-map (make-sparse-keymap))
(define-key my-keymap (kbd "t") (cons "terminal" my-terminal-map))
(define-key my-terminal-map (kbd "o") '("open-term" . term))
(define-key my-terminal-map (kbd "r") '("search-history" . counsel-shell-history))
(define-key my-terminal-map (kbd "l") '("line-mode" . term-line-mode))
(define-key my-terminal-map (kbd "c") '("char-mode" . term-char-mode))

;; magit
(defvar my-magit-map (make-sparse-keymap))
(define-key my-keymap (kbd "g") (cons "magit" my-magit-map))
(define-key my-magit-map (kbd "g") '("status" . magit-status))

;; project
(defvar my-project-map (make-sparse-keymap))
;; (define-key my-keymap (kbd "p") (cons "project" projectile-command-map))
(define-key my-keymap (kbd "p") (cons "project" project-prefix-map))
(define-key project-prefix-map (kbd "d") '("project-discovery" . project-remember-projects-under))
(define-key project-prefix-map (kbd "b") '("consult-project-buffer" . consult-project-buffer))
(define-key project-prefix-map (kbd "r") '("consult-ripgrep" . consult-ripgrep))

;; window
(defvar my-window-map (make-sparse-keymap))
(define-key my-keymap (kbd "w") (cons "wiwndow" my-window-map))
(define-key my-window-map (kbd "h") '("windmove-left" . windmove-left))
(define-key my-window-map (kbd "l") '("windmove-right" . windmove-right))
(define-key my-window-map (kbd "k") '("windmove-up" . windmove-up))
(define-key my-window-map (kbd "j") '("windmove-down" . windmove-down))
(define-key my-window-map (kbd "i") '("hpd/win-split-and-move-horizontally" .
									  hpd/win-split-and-move-horizontally))
(define-key my-window-map (kbd "v") '("hpd/win-split-and-move-vertically" .
									   hpd/win-split-and-move-vertically))
(define-key my-window-map (kbd "d") '("delete-window" . delete-window))
(define-key my-window-map (kbd "f") '("maximize-layout" . delete-other-windows))
(winner-mode)
(define-key my-window-map (kbd "u") '("undo-layout" . winner-undo))
(define-key my-window-map (kbd "r") '("redo-layout" . winner-redo))

;; buffer
(defvar my-buffer-map (make-sparse-keymap))
(define-key my-keymap (kbd "b") (cons "buffer" my-buffer-map))
(define-key my-buffer-map (kbd "b") '("switch-to-buffer" . switch-to-buffer))
(define-key my-buffer-map (kbd "s") '("save-buffer" . save-buffer))
(define-key my-buffer-map (kbd "w") '("write-file" . write-file))
(define-key my-buffer-map (kbd "k") '("kill-buffer" . kill-buffer))
(define-key my-buffer-map (kbd "f") '("find-file" . find-file))
(define-key my-buffer-map (kbd "l") '("consult-line" . consult-line))
(define-key my-buffer-map (kbd "a") '("avy-goto-char-2" . avy-goto-char-2))
(define-key my-buffer-map (kbd "n") '("next-buffer" . next-buffer))
(define-key my-buffer-map (kbd "p") '("previous-buffer" . previous-buffer))

;; emacs
(defvar my-emacs-map (make-sparse-keymap))
(define-key my-keymap (kbd "e") (cons "emacs" my-emacs-map))
(define-key my-emacs-map (kbd "q") '("save-buffers-kill-emacs" . save-buffers-kill-emacs))
(define-key my-emacs-map (kbd "s") '("desktop-save" . desktop-save))
(define-key my-emacs-map (kbd "r") '("desktop-read" . desktop-read))
(define-key my-emacs-map (kbd "e") '("eval-buffer" . eval-buffer))

;; register
(define-key my-keymap (kbd "r") (cons "register" ctl-x-r-map))
(define-key ctl-x-r-map (kbd "v") '("view-register". view-register))

;; common
(define-key my-keymap (kbd "x") '("M-x" . execute-extended-command))
(define-key my-keymap (kbd "C-h") (cons "help" help-map))

;; other
(defvar my-other-map (make-sparse-keymap))
(define-key my-keymap (kbd "s") (cons "other" my-other-map))
;;    tab-bar
(setq tab-bar-show nil)
(define-key my-other-map (kbd "t n") '("new-tab-bar" . tab-bar-new-tab))
(define-key my-other-map (kbd "t s") '("switch-tab-bar" . tab-bar-switch-to-tab))
(define-key my-other-map (kbd "t r") '("rename-tab-bar" . tab-bar-rename-tab))
(define-key my-other-map (kbd "t c") '("close-tab-bar" . tab-bar-close-tab))
;;    line
(define-key my-other-map (kbd "l c") '("comment-line" . comment-line))
(define-key my-other-map (kbd "l y") '("hpd/duplicate-line" . hpd/duplicate-line))
(define-key my-other-map (kbd "l d") '("delete-line" . kill-whole-line))
;;    smartparens
(define-key my-other-map (kbd "p r") '("sp-rewrap-sexp" . sp-rewrap-sexp))
(define-key my-other-map (kbd "p d") '("sp-unwrap-sexp" . sp-unwrap-sexp))
;; select inner text
(define-key my-other-map (kbd "p s") '("sp-select-next-thing" . sp-select-next-thing))
(define-key my-other-map (kbd "p e") '("forward-sexp" . forward-sexp))
(define-key my-other-map (kbd "p a") '("backward-sexp" . backward-sexp))

;;    code
(defvar my-code-map (make-sparse-keymap))
(define-key my-keymap (kbd "c") (cons "code" my-code-map))
(define-key my-code-map (kbd "e") '("error-list" . counsel-flycheck))
(define-key my-code-map (kbd "s") '("consult-yasnippet" . consult-yasnippet))
;; (define-key my-code-map (kbd "c") '("company-other-backend" . company-other-backend))
(define-key my-code-map (kbd "t") '("treemacs-toggle" . treemacs)) ;; project directory tree
;; (define-key my-code-map (kbd "s") '("yas-expand" . yas-expand))
(define-key my-code-map (kbd "i") '("consult-imenu" . consult-imenu))

(setq gc-cons-threshold (* 2 1000 1000))

(provide 'init)
;;; init.el ends here
