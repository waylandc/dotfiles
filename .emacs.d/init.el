(eval-and-compile
  (setq load-prefer-newer t
        package-user-dir "~/.emacs.d/elpa"
        package--init-file-ensured t
        package-enable-at-startup nil)

  (unless (file-directory-p package-user-dir)
    (make-directory package-user-dir t)))

(eval-and-compile
  (setq load-path (append load-path (directory-files package-user-dir t "^[^.]" t))))

(eval-when-compile
  (require 'package)
  (package-initialize)
;;  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)
    (package-install 'diminish)
    (package-install 'quelpa)
    ;;; bind-key.el --- A simple way to manage personal keybindings
    (package-install 'bind-key))

  (defvar use-package-always-ensure)
  (setq use-package-always-ensure t)
  (defvar use-package-expand-minimally)
  (setq use-package-expand-minimally t)

(require 'use-package))
(require 'diminish)
(require 'bind-key)

;;(use-package monokai-theme :ensure t)
 (use-package doom-themes :defer t
   :init
   (load-theme 'doom-challenger-deep t))


(defvar evil-want-C-u-scroll)
(setq evil-want-C-u-scroll t)
(use-package evil :ensure
  :init
  (evil-mode 1))
(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "C-.") nil))

(use-package ivy)

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
;; Set tab/spaces in each language mode
;;(setq-default indent-tabs-mode t)   ; use space

;; https://dougie.io/emacs/indentation/
;; Create a variable for our preferred tab width
(setq custom-tab-width 2)
(setq-default tab-width 4)
;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)
;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; WARNING: This will change your life
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
;; This will also show trailing characters as they are useful to spot.
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode) ; Enable whitespace mode everywhere
;; end tabs config

(defalias 'yes-or-no-p #'y-or-n-p)

;; enable line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; don't warn for following symlinks
(set vc-follow-symlinks t)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Extension mappings
;;(add-to-list 'auto-mode-alist '("\\.org\\" . org-mode))
;;(add-to-list 'auto-mode-alist '("\\.md\\" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.markdown\\" . markdown-mode))

(use-package smart-mode-line)

(use-package helm
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (defvar helm-idle-delay)
    (defvar helm-yas-display-key-on-candidate)
    (defvar helm-quick-update)
    (defvar helm-M-x-requires-pattern)
    (defvar helm-ff-skip-boring-files)
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (helm-mode))
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ;;("C-x C-f" . helm-find-files)
         ("M-x" . helm-M-x)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
         ("C-x c SPC" . helm-all-mark-rings)))
(ido-mode -1) ;; Turn off ido mode in case I enabled it accidentally

;; great for describing bindings
(use-package helm-descbinds
  :defer t
  :bind (("C-h b" . helm-descbinds)
         ("C-h w" . helm-descbinds)))

;; Automatically reload files was modified by external program
(use-package autorevert
  :ensure nil
  :diminish
  :hook (after-init . global-auto-revert-mode))

;; Smartparens
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)
  (setq sp-highlight-pair-overlay nil)
  (setq sp-highlight-wrap-overlay nil)
  (sp-local-pair 'rust-mode "{" nil :post-handlers '(("||\n[i]" "RET")))
  (sp-local-pair 'go-mode "{" nil :post-handlers '(("||\n[i]" "RET") ("| " "SPC")))
  (progn
    (smartparens-global-mode 1)
    (show-paren-mode t)))

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
              (width . 110) ; chars
              (height . 70) ; lines
              (left . 0)
              (top . 0)))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 110)
              (height . 70)
              (left . 0)
              (top . 0)))
      (toggle-scroll-bar 0)
      (defun font-exists-p (font) "check if font exists" (if (null(x-list-fonts font)) nil t))
      (cond
       ((if (font-exists-p "Hack Nerd Font") (set-face-attribute 'default nil :font "Hack Nerd Font-14")))
       ((if (font-exists-p "Helvetica Neue") (set-face-attribute 'default nil :font "Helvetica Neue-14")))
       ((if (font-exists-p "Optima") (set-face-attribute 'default nil :font "Optima-14")))
       ((if (font-exists-p "Roboto") (set-face-attribute 'default nil :font "Roboto Mono-12")))
       ((if (font-exists-p "Source Code Pro") (set-face-attribute 'default nil :font "Source Code Pro-12")))
       ((if (font-exists-p "Consolas") (set-face-attribute 'default nil :family "Consolas" :height 110))))
      ))

;; macOS
(when (equal system-type 'darwin)
  (defvar mac-command-key-is-meta)
  (setq mac-command-key-is-meta t)
  ;; WC these modifers aren't working. I don't notice anything different
                                        ;  (setq mac-option-modifier 'super)
                                        ;  (setq mac-command-modifier 'meta)
  (setq ns-auto-hide-menu-bar t)
  (setq ns-use-proxy-icon nil)
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
  :ensure t
  :diminish company-mode
  :config
  (setq company-idle-delay 1)
  (defvar company-minimum-prefex-length)
  (setq company-minimum-prefex-length 1)
  (add-hook 'after-init-hook #'global-company-mode)
  )

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package go-guru :after go-mode)

(use-package go-mode
  :mode "\\.go\\'"
  :init
  (setq gofmt-command "goimports"     ; use goimports instead of gofmt
        go-fontify-function-calls nil ; https://lupan.pl/dotemacs/
        company-idle-delay 1)         ; wait 1s before company popup
  :bind
  (:map go-mode-map
        ;WC I think this is same as godef-jump ("M-."      . go-guru-definition)
        ;WC opens new buffer ("M-."      . godef-jump)
        ("M-."      . godef-jump-other-window)
        ; navigate backwards after godef-jump
        ("M-*"      . pop-tag-mark)
        ;WC conflict with helm-mini ("C-c h"    . go-guru-hl-identifier)
        ("C-c d"    . lsp-describe-thing-at-point)
        ("C-c g"    . godoc)
        ;      ("C-c P"   . my-godoc-package)
        ; WC I think this conflicts use C-M-i ("C-i"      . company-indent-or-complete-common)
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

(use-package flycheck-rust :ensure t
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package rust-mode :ensure t
  :mode "\\.rs\\'"
  :config
  (setq-default indent-tabs-mode nil	;; rustfmt takes care of spaces, just don't use tabs
                company-idle-delay 1         		;; wait 1s before company popup
                rust-format-on-save t
                tab-width 4)
  (defvar lsp-rust-server)
  (setq lsp-rust-server 'rust-analyzer)
  ) 			;; requires `rustup component add rustfmt

(use-package racer :ensure t
  :config
  (progn
    (add-hook 'rust-mode-hook #'racer-mode) ;; Activate racer in rust buffers.
    (add-hook 'racer-mode-hook #'eldoc-mode) ;; Shows signature of current function in minibuffer.
    ;; Rust completions with Company and Racer.
    (add-hook 'racer-mode-hook #'company-mode)
    ))

;; WC doesn't work (need to hit ENTER)
;;Map TAB key to completions.
;(local-set-key (kbd "TAB") 'company-indent-or-complete-common)
;(setq company-tooltip-align-annotations t)

;; Path to rust source.
(when (equal system-type 'gnu/linux)
  (setq racer-rust-src-path (concat (getenv "HOME") "/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"))
  (setq racer-cmd (concat (getenv "CARGO_HOME") "/bin/racer")))
(when (equal system-type 'darwin)
  (setq racer-rust-src-path (concat (getenv "HOME") "/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"))
  ;; Racer bin path.
  (setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer")))

(use-package cargo :ensure t
  :config
  (progn
    (add-hook 'rust-mode-hook 'cargo-minor-mode)))

(use-package lsp-mode
  :ensure t
    ;; reformat code and add missing (or remove old) imports
  :config
  (add-hook 'go-mode-hook #'lsp)
    (add-hook 'rust-mode-hook #'lsp))

;;Set up before-save hooks to format buffer and add/delete imports.
;;Make sure you don't have other gofmt/goimports hooks enabled.

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
;;(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package company-lsp :commands company-lsp)

(use-package lsp-ui
  :ensure t
  :after (lsp-mode)
  :commands lsp-ui-mode
  :init
  (defvar lsp-ui-side-enable)
  (defvar lsp-ui-flycheck-enable)
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-include-signature t
        lsp-ui-peek-enable t
        lsp-ui-side-enable t
        lsp-ui-sideline-show-hover nil
        lsp-ui-flycheck-enable t)
        ;;lsp-ui-imenu-enable t
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

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
  (org-indent-mode)
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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-highlight-search t t)
 '(ag-reuse-buffers t t)
 '(ag-reuse-window t t)
 '(custom-safe-themes
   '("a3b6a3708c6692674196266aad1cb19188a6da7b4f961e1369a68f06577afa16" "1623aa627fecd5877246f48199b8e2856647c99c6acdab506173f9bb8b0a41ac" "d88049c628f3a8a92f9e46982d3e891867e4991de2b3a714f29f9f5eb91638c1" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "6b80b5b0762a814c62ce858e9d72745a05dd5fc66f821a1c5023b4f2a76bc910" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "4bca89c1004e24981c840d3a32755bf859a6910c65b829d9441814000cf6c3d0" "bf387180109d222aee6bb089db48ed38403a1e330c9ec69fe1f52460a8936b66" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "37a4701758378c93159ad6c7aceb19fd6fb523e044efe47f2116bc7398ce20c9" "74ba9ed7161a26bfe04580279b8cad163c00b802f54c574bfa5d924b99daa4b9" "6c3b5f4391572c4176908bb30eddc1718344b8eaff50e162e36f271f6de015ca" "9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "f2927d7d87e8207fa9a0a003c0f222d45c948845de162c885bf6ad2a255babfd" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default))
 '(ivy-count-format "%d/%d ")
 '(ivy-use-virtual-buffers t)
 '(magit-auto-revert-mode nil)
 '(org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●") t)
 '(package-selected-packages
   '(default-text-scale doom-themes smart-mode-line yasnippet cyberpunk-theme cyberpunk-2019-theme ample-theme ivy which-key web-mode vue-mode use-package twilight-bright-theme tide subatomic256-theme solarized-theme smartparens rainbow-mode rainbow-delimiters racer protobuf-mode prettier-js pbcopy molokai-theme magit lsp-ui js2-mode hungry-delete gotest go-tag go-guru go-dlv flycheck-rust evil diminish dap-mode counsel company-quickhelp company-posframe company-lsp company-go company-box color-theme-sanityinc-tomorrow cargo autopair all-the-icons ag 4clojure))
 '(warning-suppress-types '((bytecomp) (bytecomp) (bytecomp))))
