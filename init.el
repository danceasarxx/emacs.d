(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; define function to shutdown emacs server instance
(defun arewa-server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

; No more "yes" or "no"
(defalias 'yes-or-no-p 'y-or-n-p)

;; Load latest source files only
(setq load-prefer-newer t)

;; enable line mode globally
(global-linum-mode t)
(setq linum-format "%-4d")

;; No tabs zone
(setq-default indent-tabs-mode nil)

;; Save sessions like sublime
(desktop-save-mode 1)

;; Useless menubar
(menu-bar-mode -1)

;; Move customizations to another file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; I don't like typing
(ido-mode t)
(ido-everywhere t)

;; Use pure background
(defun on-after-init ()
  (unless (display-graphic-p (selected-frame))
    (set-face-background 'default "unspecified-bg" (selected-frame))))
(add-hook 'window-setup-hook 'on-after-init)

;; IBuffer
(use-package ibuffer
  :bind (("C-x C-b" . ibuffer-other-window)))

;; smex
(use-package smex
  :ensure t
  :bind (("M-x" . smex))
  :config (smex-initialize))

;; aggressive indent
(use-package aggressive-indent
  :config (global-aggressive-indent-mode t))

;; elpy
(use-package elpy
  :ensure t
  :init (add-hook 'python-mode-hook #'elpy-enable)
  :config
  (use-package flycheck
    :ensure t
    :config
    (progn
      (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode))))


;; Projectile
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config (projectile-global-mode))

;; Smart parens
;; (use-package smartparens
;;   :ensure t
;;   :diminish smartparens-mode
;;   :config
;;   (progn
;;     (require 'smartparens-config)
;;     (smartparens-global-mode t)))

(use-package company
  :ensure t  
  :bind ("<C-tab>" . company-complete)
  :init (add-hook 'after-init-hook 'global-company-mode))

(use-package expand-region
  :ensure t
  :bind ("C-c =" . er/expand-region))

(use-package crontab-mode
  :ensure t
  :defer t)

(use-package gitconfig-mode
  :ensure t
  :defer t)

(use-package gitignore-mode
  :ensure t
  :defer t)

(use-package git-gutter
  :ensure t
  :defer t
  :init (add-hook 'after-init-hook 'global-git-gutter-mode))

(use-package ido-ubiquitous
  :ensure t
  :config (ido-ubiquitous-mode t))

(use-package neotree
  :ensure t
  :bind (([f8] . neotree-toggle))
  :config
  (progn
    (setq neo-smart-open t)
    (setq projectile-switch-project-action 'neotree-projectile-action)
    (setq neo-window-width 40)))

(use-package json-mode
  :ensure t
  :defer t
  :config
  (progn
    (bind-key "{" #'paredit-open-curly json-mode-map)
    (bind-key "}" #'paredit-close-curly json-mode-map)))

(use-package json-reformat
  :ensure t
  :defer t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :config
  (progn
    (setenv "GIT_PAGER" "")
    (setq magit-completing-read-function 'magit-ido-completing-read)))

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)))

(use-package org
  :ensure t
  :defer t
  :init
  (setq org-replace-disputed-keys t
        org-default-notes-file (expand-file-name "Notes/journal.org" (getenv "HOME")))
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((awk . t)
     (emacs-lisp . t)
     (python . t)
     (sh . t))))

(use-package paredit
  :diminish paredit-mode
  :ensure t
  :init
  (progn
    (add-hook 'json-mode-hook 'enable-paredit-mode)
    (add-hook 'lisp-mode-hook 'enable-paredit-mode)
    (add-hook 'emacs-lisp-mode 'enable-paredit-mode)
    (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)))

(use-package paredit-everywhere
  :ensure t
  :init (add-hook 'prog-mode-hook 'paredit-everywhere-mode))

(use-package pip-requirements
  :ensure t
  :defer t)

(use-package rainbow-mode
  :ensure t
  :defer t)

(use-package rainbow-delimiters
  :ensure t
  :defer t
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package regex-tool
  :ensure t
  :defer t)

(use-package whitespace-cleanup-mode
  :ensure t
  :config (global-whitespace-cleanup-mode))
