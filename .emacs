(require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-prioriti>
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes `(spacemacs-dark))
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(package-selected-packages
   '(xclip smartparens js2-mode windresize yasnippet which-key use-package spacemacs-theme popup>
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Full screen on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; ace window
(global-set-key (kbd "M-m") 'ace-select-window)
(setq aw-dispatch-always t)

;; Treemacs
(global-set-key (kbd "M-0") 'treemacs-select-window)

;; Windresize
(global-set-key (kbd "C-x w") 'windresize)

;; describe thing at point
(global-set-key (kbd "C-x j d") 'lsp-describe-thing-at-point)

;; comment line
(global-set-key (kbd "C-x c") 'comment-line)

;; elixir format hook
(add-hook 'elixir-mode-hook
        (lambda () (add-hook 'before-save-hook 'elixir-format nil t))
        )

;; javascript mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; Disable stuff
(menu-bar-mode -1)
(tool-bar-mode -1)
;; Enable stuff
(which-key-mode 1)
(ivy-mode 1)
(yas-minor-mode 1)
(smartparens-global-mode 1)
;; Set stuff
(setq gc-cons-threshold 10000000)
(setq read-process-output-max (* 1024 1024))

;; Emacs dashboard
(require 'dashboard)
(setq dashboard-banner-logo-title "Welcome to space, Isaac")
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-show-shortcuts t)
(setq dashboard-startup-banner "/home/isaac/.emacs.d/helix.gif")
(dashboard-setup-startup-hook)

;; Keybindings
(global-set-key (kbd "C-x j t") 'projectile-grep)
(global-set-key (kbd "C-x j f") 'projectile-find-file)
           
;; Custom
(defun smart-beginning-of-line ()
  (interactive)
  (let ((pt (point)))
    (beginning-of-line)
    (when (eq pt (point))
      (beginning-of-line-text))))
(global-set-key (kbd "C-a") 'smart-beginning-of-line)

;; Flycheck config
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :hook
  (prog-mode . flyspell-prog-mode))

;; Company configuration
(use-package company
  :ensure t
  :diminish company-mode
  :hook
  (prog-mode . yas-minor-mode)
  :hook
  (prog-mode . global-company-mode)
 :config
(setq company-backends '(company-capf,
                         company-keywords,
                         company-semantic,
                         company-files,
                         company-etags,
                         company-elisp,
                         company-yasnippet))
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)
  (setq company-echo-delay 0)
  (global-company-mode 1)
)

(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :diminish lsp-ui
  :init (lsp-ui-mode)
  :hook ((lsp-mode . lsp-ui-mode))
  :config
  (setq lsp-ui-peek-enable t)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-doc-enable t)
  (setq lsp-enable-file-watchers nil)
  )

;; Elixir ls
(use-package lsp-mode
  :ensure t
  :diminish lsp-mode
  :bind
  (("M-." . lsp-find-definition)
   ("M-," . lsp-find-references)
   ("<f7>" . lsp-format-buffer)
   )
  :hook
  (js2-mode . lsp)
  (elixir-mode . lsp)
  :init
  '(lsp-mode)
  (add-to-list 'exec-path "/root/.elixir-ls/elixir-ls/release"))
