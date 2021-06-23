;;(eval-and-compile
  (setq load-prefer-newer t
        package-user-dir "~/.emacs.d/elpa"
        package--init-file-ensured t
        package-enable-at-startup nil)

  (unless (file-directory-p package-user-dir)
    (make-directory package-user-dir t))

;;(eval-and-compile
  (setq load-path (append load-path (directory-files package-user-dir t "^[^.]" t)))

;;(eval-when-compile
(require 'package)
(setq package-archives
  '(("org" . "https://orgmode.org/elpa")
   ("gnu" . "https://elpa.gnu.org/packages/")
   ("melpa" . "https://melpa.org/packages/")))
  ;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  ;;(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
  ;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (package-install 'diminish)
  (package-install 'quelpa)
  (package-install 'bind-key))

(defvar use-package-always-ensure)
(setq use-package-always-ensure t)
(defvar use-package-expand-minimally)
(setq use-package-expand-minimally t)

(require 'use-package)
(require 'diminish)
(require 'bind-key)

(use-package material-theme :ensure)
(use-package doom-themes :ensure)
(use-package challenger-deep-theme :ensure t)
;;(load-theme 'doom-challenger-deep t)
(load-theme 'material t)
;;(load-theme 'doom-nord t)
;;(setq default-frame-alist '((cursor-color . "red")))
;;(set-face-background 'cursor 'red)
;;(set-face-attribute 'cursor nil :background "red")
(use-package spacemacs-theme :defer t)
;;(load-theme 'spacemacs-dark t)
;
(defun dark-mode ()
  "Default theme and font size.  Pendant: (presentation-mode)."
  (interactive)

  ;;(set-face-attribute 'default nil :height 150)
  ;; Themes
  ;; (set-frame-parameter nil 'background-mode 'dark)

  ;; Dark, High Contrast <- favorite
  (load-theme 'doom-Iosvkem)
  (setq frame-background-mode (quote dark))

  ;; Dark, Lowest contrast
  ;; (load-theme 'zenburn)
  )

(defun light-mode ()
  "Enables a light theme."
  (interactive)
  ;;(mapcar 'disable-theme custom-enabled-themes)
  (load-theme 'spacemacs-light t))

;;(light-mode)

(defun zoom-in ()
  (interactive)
  (let ((x (+ (face-attribute 'default :height)
              10)))
    (set-face-attribute 'default nil :height x)))

(defun zoom-out ()
  (interactive)
  (let ((x (- (face-attribute 'default :height)
              10)))
    (set-face-attribute 'default nil :height x)))

(define-key global-map (kbd "C-1") 'zoom-in)
(define-key global-map (kbd "C-0") 'zoom-out)

;; Set default font
(set-face-attribute 'default nil
                    :family "Roboto Mono"
                    :height 100
                    :weight 'normal
                    :width 'normal)

(defvar evil-want-C-u-scroll)
(setq evil-want-C-u-scroll t)
(use-package evil :ensure
  :init
  (evil-mode 1))
(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "C-.") nil))

(use-package ivy)

;; WC Nov 2020 this is broken in windows, causes error
;; setup ivy, aounsel and swiper for completion and search
 (use-package counsel
   :diminish ivy-mode counsel-mode
   :bind
   ("C-s" . swiper)
   :hook
   (after-init . ivy-mode)
   (ivy-mode . counsel-mode)
   :custom
   (ivy-use-virtual-buffers t)
   (ivy-count-format "%d/%d "))

;; ag is a faster grep tool to find text in files
;; brew install the_silver_searcher
(use-package ag
  :custom
  (ag-highlight-search t)
  (ag-reuse-buffers t)
  (ag-reuse-window t)
  :bind
  ("M-s a" . a-project)
  :config
  (use-package wgrep-ag))

;; Microsoft's language server protocol, LSP Server
(use-package server
  :ensure nil
  :hook (after-init . server-mode))

;; Default Encoding
(prefer-coding-system 'utf-8-unix)
(set-locale-environment "en_US.UTF-8")
(set-default-coding-systems 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8) ; included by set-selection-coding-system
(set-keyboard-coding-system 'utf-8) ; configured by prefer-coding-system
(set-terminal-coding-system 'utf-8) ; configured by prefer-coding-system
(setq buffer-file-coding-system 'utf-8) ; utf-8-unix
(setq save-buffer-coding-system 'utf-8-unix) ; nil
(setq process-coding-system-alist
      (cons '("grep" utf-8 . utf-8) process-coding-system-alist))

;; Quiet Startup
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(tool-bar-mode 0)
(menu-bar-mode 0)
(display-time-mode 1)
(set-fringe-mode 10)
(defun display-startup-echo-area-message ()
  (message ""))
(xterm-mouse-mode 1)
(setq frame-title-format nil)
(setq ring-bell-function 'ignore)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ; Show path if names are same
;;(setq adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*")
;;(setq adaptive-fill-first-line-regexp "^* *$")
(setq sentence-end "\\([。、！？]\\|……\\|[,.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)
(setq delete-by-moving-to-trash t)    ; Deleting files go to OS's trash folder
(setq make-backup-files nil)          ; Forbide to make backup files
(setq auto-save-default nil)          ; Disable auto save
(setq set-mark-command-repeat-pop t)  ; Repeating C-SPC after popping mark pops it again
(setq track-eol t)      ; Keep cursor at end of lines.
(setq line-move-visual nil)   ; To be required by track-eol
(setq-default kill-whole-line t)  ; Kill line including '\n'
(setq select-enable-clipboard t)
;; make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; always display images inline
;; this can be done locally within the file by using:
;; #+STARTUP: inlineimages
;; #+STARTUP: noinlineimages
(setq org-startup-with-inline-images t)

;; Set tab/spaces in each language mode
;;(setq-default indent-tabs-mode t)   ; use space

;; https://dougie.io/emacs/indentation/
;; Create a variable for our preferred tab width
(setq custom-tab-width 4)
;;(setq indent-tabs-mode nil)
;;(setq tab-width 4)
;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (interactive) (setq indent-tabs-mode nil))
(defun enable-tabs  () (interactive)
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

(defun enable-space-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode nil)
  (setq tab-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)

;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

(setq-default js-indent-level custom-tab-width) ;; Javascript

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)
(setq-default evil-shift-width custom-tab-width)

(defun how-many-region (begin end regexp &optional interactive)
  "Print number of non-trivial matches for REGEXP in region.
   Non-interactive arguments are Begin End Regexp"
  (interactive "r\nsHow many matches for (regexp): \np")
  (let ((count 0) opoint)
    (save-excursion
      (setq end (or end (point-max)))
      (goto-char (or begin (point)))
      (while (and (< (setq opoint (point)) end)
                  (re-search-forward regexp end t))
        (if (= opoint (point))
            (forward-char 1)
          (setq count (1+ count))))
      (if interactive (message "%d occurrences" count))
      count)))

(defun infer-indentation-style ()
  ;; if our source file uses tabs, we use tabs, if spaces spaces, and if
  ;; neither, we use the current indent-tabs-mode
  (let ((space-count (how-many-region (point-min) (point-max) "^  "))
        (tab-count (how-many-region (point-min) (point-max) "^\t")))
    (if (> space-count tab-count) (setq indent-tabs-mode nil))
    (if (> tab-count space-count) (setq indent-tabs-mode t))))


;; WARNING: This will change your life
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
;; This will also show trailing characters as they are useful to spot.
(defvar whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:foreground "#636363")))))
(defvar whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode) ; Enable whitespace mode everywhere
;; end tabs config

(add-hook 'python-mode-hook
    (lambda ()
      (setq indent-tabs-mode nil)
      (infer-indentation-style)))

(defalias 'yes-or-no-p #'y-or-n-p)

;; enable line numbers
(column-number-mode)
;;(global-display-line-numbers-mode t)

;; don't warn for following symlinks
(set vc-follow-symlinks t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Extension mappings
;;(add-to-list 'auto-mode-alist '("\\.org\\" . org-mode))
;;(add-to-list 'auto-mode-alist '("\\.md\\" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.markdown\\" . markdown-mode))

(use-package smart-mode-line)

;;(use-package helm
;;  :diminish helm-mode
;;  :init
;;  (progn
;;    (require 'helm-config)
;;    (setq helm-candidate-number-limit 100)
;;    ;; From https://gist.github.com/antifuchs/9238468
;;    (defvar helm-idle-delay)
;;    (defvar helm-yas-display-key-on-candidate)
;;    (defvar helm-quick-update)
;;    (defvar helm-M-x-requires-pattern)
;;    (defvar helm-ff-skip-boring-files)
;;    (setq helm-idle-delay 0.0 ;; update fast sources immediately (doesn't).
;;          helm-input-idle-delay 0.01  ;; this actually updates things relatively quickly.
;;          helm-yas-display-key-on-candidate t
;;          helm-quick-update t
;;          helm-M-x-requires-pattern nil
;;          helm-ff-skip-boring-files t)
;;    (helm-mode))
;;  :bind (("C-c h" . helm-mini)
;;         ("C-h a" . helm-apropos)
;;         ("C-x C-b" . helm-buffers-list)
;;         ("C-x b" . helm-buffers-list)
;;         ("M-y" . helm-show-kill-ring)
;;         ;;("C-x C-f" . helm-find-files)
;;         ("M-x" . helm-M-x)
;;         ("C-x c o" . helm-occur)
;;         ("C-x c s" . helm-swoop)
;;         ("C-x c y" . helm-yas-complete)
;;         ("C-x c Y" . helm-yas-create-snippet-on-region)
;;         ("C-x c b" . my/helm-do-grep-book-notes)
;;         ("C-x c SPC" . helm-all-mark-rings)))

;; great for describing bindings
;;(use-package helm-descbinds
;;  :defer t
;;  :bind (("C-h b" . helm-descbinds)
;;         ("C-h w" . helm-descbinds)))

;; Turn off ido mode in case I enabled it accidentally
(ido-mode -1)

;; Automatically reload files was modified by external program
(use-package autorevert
  :ensure nil
  :diminish
  :hook (after-init . global-auto-revert-mode))

;; this is fairly useless now that I mainly use in terminal
(if (display-graphic-p)
    (progn
      ;; keybinding to scale text is C+M+- C+M+=
      (use-package default-text-scale
        :defer 1
        :config
        (default-text-scale-mode))
      ;; UI parts
      ;; set initial position of gui window
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 130) ;; chars
              (height . 50) ;; lines
              ))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 130)
              (height . 50)
              ))
      (toggle-scroll-bar 0)
      (defun font-exists-p (font) "check if font exists" (if (null(x-list-fonts font)) nil t))
      ;;(cond
      ;; ((if (font-exists-p "Hack Nerd Font") (set-face-attribute 'default nil :font "Hack Nerd Font-14")))
      ;; ((if (font-exists-p "Helvetica Neue") (set-face-attribute 'default nil :font "Helvetica Neue-14")))
      ;; ((if (font-exists-p "Optima") (set-face-attribute 'default nil :font "Optima-14")))
      ;; ((if (font-exists-p "Roboto") (set-face-attribute 'default nil :font "Roboto Mono-12")))
      ;; ((if (font-exists-p "Source Code Pro") (set-face-attribute 'default nil :font "Source Code Pro-12")))
      ;; ((if (font-exists-p "Consolas") (set-face-attribute 'default nil :family "Consolas" :height 110))))
      ))

;; macOS
(when (equal system-type 'darwin)
  (defvar mac-command-key-is-meta)
  (setq mac-command-key-is-meta t)
  ;; WC these modifers aren't working. I don't notice anything different
  ;; (setq mac-option-modifier 'super)
  ;; (setq mac-command-modifier 'meta)
  (defvar ns-auto-hide-menu-bar t)
  (defvar ns-use-proxy-icon nil)
  (setq initial-frame-alist
        (append
         '((ns-transparent-titlebar . t)
           (ns-appearance . dark)
           (vertical-scroll-bars . nil)
           (internal-border-width . 0)))))

;; pbcopy
(use-package pbcopy
  :if (eq system-type 'darwin)
  :hook (dashboard-mode . (turn-on-pbcopy)))

(use-package all-the-icons)

;; which-key will show you what commands available if you pause 1s in middle of cmd
(use-package which-key
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

;; rainbow mode is a minor mode which displays strings representing colors with the color as background
(use-package rainbow-mode
  :diminish rainbow-mode
  :config
    (add-hook 'prog-mode-hook 'rainbow-mode))

;; WC we're not using yas yet so comment it out
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :hook (after-init . yas-global-mode))

;; Magit
(use-package magit
  :custom
  (magit-auto-revert-mode nil)
  :bind
  ("M-g s" . magit-status))

(use-package company
  :ensure
  :custom
  (company-idle-delay 0.2) ;; how long to wait until popup
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last)))

(use-package yasnippet
  :ensure
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package lsp-mode
  :commands lsp
  :init
  (setq lsp-keymap-prefix "H-l")
  :config
  (lsp-enable-which-key-integration t)
  :custom
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  ;; reformat Go code and add missing (or remove old) imports
  :hook ((before-save . my-lsp-format-buffer)
         (before-save . my-lsp-organize-imports))
  :bind (("C-c e n" . flymake-goto-next-error)
         ("C-c e p" . flymake-goto-prev-error)
         ("C-c e r" . lsp-find-references)
         ("C-c e R" . lsp-rename)
         ("C-c e i" . lsp-find-implementation)
         ("C-c e t" . lsp-find-type-definition)))

(use-package lsp-ui
  :init
  (setq lsp-ui-doc-enable nil
        lsp-ui-doc-delay 3
        ;;lsp-ui-doc-use-childframe t
        ;;lsp-ui-doc-position 'top
        ;;lsp-ui-doc-alignment 'frame
        lsp-ui-doc-include-signature t
        lsp-enable-symbol-highlighting t
        lsp-ui-sideline-show-hover t
        ;;lsp-ui-sideline-delay 0.5
        lsp-ui-peek-always-show t)
  :commands lsp-ui-mode
  :bind (:map evil-normal-state-map
              ;; use C-x C-space to go back to previous file
              ("gd" . lsp-ui-peek-find-definitions)
              ("gr" . lsp-ui-peek-find-references)
              ("Ni" . lsp-ui-imenu)))
        ;;lsp-ui-sideline-delay 5.0)
;;  :bind (("C-c d" . lsp-ui-doc-show)
;;         ("C-c i" . lsp-ui-imenu)))

(when (>= emacs-major-version 26)
  (defun my-rustic-mode-hook-fn ()
    "needed for lsp-format-buffer to indent with 4 spaces"
    (setq tab-width 4
          indent-tabs-mode nil))

  (use-package rustic
    :init
    ;; to use rustic-mode even if rust-mode also installed
    ;;(setq auto-mode-alist (delete '("\\.rs\\'" . rust-mode) auto-mode-alist))
    (setq rustic-format-trigger 'on-save)
    :hook (rustic-mode . my-rustic-mode-hook-fn)))

(use-package cargo :defer)

(use-package go-guru :after go-mode)

(use-package go-mode
  :mode "\\.go\\'"
  :init
  (setq gofmt-command "goimports"     ;; use goimports instead of gofmt
        go-fontify-function-calls nil ;; https://lupan.pl/dotemacs/
        company-idle-delay 1)         ;; wait 1s before company popup
  :bind
  (:map go-mode-map
        ;; WC I think this is same as godef-jump ("M-."      . go-guru-definition)
        ;; WC opens new buffer ("M-."      . godef-jump)
        ("M-."      . godef-jump-other-window)
        ;; navigate backwards after godef-jump
        ("M-*"      . pop-tag-mark)
        ;; WC conflict with helm-mini ("C-c h"    . go-guru-hl-identifier)
        ("C-c d"    . lsp-describe-thing-at-point)
        ("C-c g"    . godoc)
        ;; ("C-c P"   . my-godoc-package)
        ;; WC I think this conflicts use C-M-i ("C-i"      . company-indent-or-complete-common)
        ("C-M-i"    . company-indent-or-complete-common)
        )
  :hook ((go-mode . lsp)))
;;(go-mode . smartparens-mode)))


;;  :config
;;(add-hook 'go-mode-hook #'smartparens-mode)
;; (add-hook 'go-mode-hook (lambda () (setq tab-width 4)))
;; (add-hook 'before-save-hook #'gofmt-before-save)
;; (set (make-local-variable 'compile-command) "go build -v && go test -v && go vet"))


;; Rust
(use-package flycheck :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  ;; prevent flycheck from checking our init.el
  (setq-default flycheck-disabled-checkers 
                (append flycheck-disabled-checkers 
                        '(emacs-lisp-checkdoc)
                        '(javascript-jshint)
                        '(json-jsonlist)))
  (setq-default flycheck-temp-prefix ".flycheck"))


;; Tide is dev environment for JS/TS, providing completions, jump to defn
;; eldoc/flycheck integration
(defun setup-tide-mode ()
  "Setup function for tide."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(add-hook 'js-mode-hook #'setup-tide-mode)

(use-package js2-mode
  :ensure t
  :config
  (add-hook 'js-mode-hook 'js2-minor-mode))

;; Prettier for best JS formatting
;; Note - you have have prettier installed on OS npm install -g prettier
(use-package prettier-js
  :ensure t
  :config
  (add-hook 'web-mode-hook 'prettier-js-mode))

(use-package web-mode
  :ensure t
  :mode (("\\.html\\'" . web-mode))
  :config
  (defvar web-mode-enable-comment-keywords)
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2

        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        web-mode-enable-auto-indentation nil
        )
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
                (setup-tide-mode))))
  ;; enable typescript-tslint checker
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode))

(use-package tide
  :hook (web-mode . setup-tide-mode)
  :ensure t)

;; VueJS setup
(use-package vue-mode)
(use-package vue-html-mode)

(defvar vue-mode-packages)
(setq vue-mode-packages
      '(vue-mode))
(defvar vue-mode-excluded-packages)
(setq vue-mode-excluded-packages '())
(defun vue-mode/init-vue-mode ()
  "Initialize my package"
  (use-package vue-mode))

;; Protobufs mode
(use-package protobuf-mode)

(defconst my-protobuf-style
  '((c-basic-offset . 4)
    (indent-tabs-mode . t)))

(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "my-style" my-protobuf-style t)))

(use-package solidity-mode
  :ensure t
  :no-require t)
(use-package company-solidity
  :ensure t
  :no-require t
  :config (add-hook 'solidity-mode-hook
                    (lambda ()
                      (my-company-add-backend-locally 'company-solidity))))

(use-package lsp-python-ms
  :defer 0.3
  :custom (lsp-python-ms-auto-install-server t))

(use-package blacken
  :delight
  :hook (python-mode . blacken-mode)
  :custom (blacken-line-length 79))

(use-package python
  :delight "π "
  :bind (("M-[" . python-nav-backward-block)
         ("M-]" . python-nav-forward-block))
  :preface
  (defun python-remove-unused-imports()
    "Removes unused imports and unused variables with autoflake."
    (interactive)
    (if (executable-find "autoflake")
        (progn
          (shell-command (format "autoflake --remove-all-unused-imports -i %s"
                                 (shell-quote-argument (buffer-file-name))))
          (revert-buffer t t t))
      (warn "python-mode: Cannot find autoflake executable."))))

(use-package poetry
  :ensure t)

;; Setup LLDB debugging for use in Rust
;; WC todo dap-lldb is unavailable
                                        ;(use-package dap-mode
                                        ;  :ensure t
                                        ;  :config
                                        ;    (dap-mode 1)
                                        ;    (dap-ui-mode 1)
                                        ;    (dap-tooltip-mode 1)
                                        ;    (tooltip-mode 1))
                                        ;(use-package dap-lldb :ensure t)

;; which-key provides overview of which keybindings are available based
;; on the prefix keys you entered
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(defun wc/org-mode-setup ()
  (defvar org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil)
  (diminish org-indent-mode))

(use-package org
  :defer t
  :hook (org-mode . wc/org-mode-setup)
  :config
  (defvar org-log-time)
  (setq org-todo-keywords
        '((sequence "STARTED(s)" "TODO(t)" "|" "WAITING(w@/!)" "DONE(x!)" "CANCELLED(c)"))
        org-todo-keyword-faces
        '(("TODO" . (foreground "green" :weight bold))
          ("DONE" . (:foreground "cyan" :weight bold))
          ("WAITING" . (:foreground "red" :weight bold))
          ("CANCELLED" . (:foreground "gray")))
        org-startup-folded 'content
        org-hide-block-startup nil
        org-src-fontify-natively t
        org-log-time 'time))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Replace list hyphen with dot
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) \"•\"))))))

;; make sure org-indent face is available
(require 'org-indent)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-highlight-search t t)
 '(ag-reuse-buffers t t)
 '(ag-reuse-window t t)
 '(blacken-line-length 79 t)
 '(custom-safe-themes
   '("4a8d4375d90a7051115db94ed40e9abb2c0766e80e228ecad60e06b3b397acab" "75b8719c741c6d7afa290e0bb394d809f0cc62045b93e1d66cd646907f8e6d43" "5379937b99998e0510bd37ae072c7f57e26da7a11e9fb7bced8b94ccc766c804" "0a41da554c41c9169bdaba5745468608706c9046231bbbc0d155af1a12f32271" "2050674326d536ddd3dcea87e077d27071cfbbe974a4540b1a57b6b672f64c51" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "08a27c4cde8fcbb2869d71fdc9fa47ab7e4d31c27d40d59bf05729c4640ce834" "7a994c16aa550678846e82edc8c9d6a7d39cc6564baaaacc305a3fdc0bd8725f" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "6c9cbcdfd0e373dc30197c5059f79c25c07035ff5d0cc42aa045614d3919dab4" "93ed23c504b202cf96ee591138b0012c295338f38046a1f3c14522d4a64d7308" "c086fe46209696a2d01752c0216ed72fd6faeabaaaa40db9fc1518abebaf700d" "d2e0c53dbc47b35815315fae5f352afd2c56fa8e69752090990563200daae434" "a3b6a3708c6692674196266aad1cb19188a6da7b4f961e1369a68f06577afa16" "1623aa627fecd5877246f48199b8e2856647c99c6acdab506173f9bb8b0a41ac" "d88049c628f3a8a92f9e46982d3e891867e4991de2b3a714f29f9f5eb91638c1" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "4bca89c1004e24981c840d3a32755bf859a6910c65b829d9441814000cf6c3d0" "bf387180109d222aee6bb089db48ed38403a1e330c9ec69fe1f52460a8936b66" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "37a4701758378c93159ad6c7aceb19fd6fb523e044efe47f2116bc7398ce20c9" "74ba9ed7161a26bfe04580279b8cad163c00b802f54c574bfa5d924b99daa4b9" "6c3b5f4391572c4176908bb30eddc1718344b8eaff50e162e36f271f6de015ca" "9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "f2927d7d87e8207fa9a0a003c0f222d45c948845de162c885bf6ad2a255babfd" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))
 '(ivy-count-format "%d/%d ")
 '(ivy-use-virtual-buffers t)
 '(lsp-python-ms-auto-install-server t)
 '(lsp-restart 'auto-restart)
 '(magit-auto-revert-mode nil)
 '(org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●") t)
 '(package-selected-packages
   '(material-theme material emacs-material-theme company-jedi default-text-scale doom-themes smart-mode-line yasnippet cyberpunk-theme cyberpunk-2019-theme ample-theme ivy which-key web-mode vue-mode use-package twilight-bright-theme tide subatomic256-theme solarized-theme rainbow-mode rainbow-delimiters racer protobuf-mode prettier-js pbcopy molokai-theme magit js2-mode hungry-delete gotest go-tag go-guru go-dlv evil diminish dap-mode counsel company-quickhelp company-posframe company-go company-box color-theme-sanityinc-tomorrow cargo autopair all-the-icons ag 4clojure))
 '(warning-suppress-types '((bytecomp) (bytecomp) (bytecomp))))
