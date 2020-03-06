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
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)
    (package-install 'diminish)
    (package-install 'quelpa)
    (package-install 'bind-key))

  (setq use-package-always-ensure t)
  (setq use-package-expand-minimally t)

  (require 'use-package))
(require 'diminish)
(require 'bind-key)

                                        ;(use-package monokai-theme :ensure t)
;; (use-package spacemacs-theme :defer t
;;   :init
;;   (load-theme 'spacemacs-dark t))

(use-package color-theme-sanityinc-tomorrow :defer t
  :init
  (load-theme 'sanityinc-tomorrow-eighties t))


(use-package evil :ensure
  :init
  (evil-mode 1))

;; Setup font by checking if it exists on this system first
;; List them in order of preference as it'll use the first one found
;; WC why are we doiing fonts again here??
;;(defun font-exists-p (font) "check if font exists" (if (null(x-list-fonts font)) nil t))
;;  (cond
;;    ((if (font-exists-p "Hack Nerd Font") (set-face-attribute 'default nil :font "Hack Nerd Font-14")))
;;    ((if (font-exists-p "Helvetica Neue") (set-face-attribute 'default nil :font "Helvetica Neue-14")))
;;    ((if (font-exists-p "Optima") (set-face-attribute 'default nil :font "Optima-14")))
;;    ((if (font-exists-p "Roboto") (set-face-attribute 'default nil :font "Roboto Mono-12")))
;;    ((if (font-exists-p "Source Code Pro") (set-face-attribute 'default nil :font "Source Code Pro-12")))
;;    ((if (font-exists-p "Consolas") (set-face-attribute 'default nil :family "Consolas" :height 110))))

;; setup ivy, counsel and swiper for completion and search
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
(use-package ag
  :custom
  (ag-highlight-search t)
  (ag-reuse-buffers t)
  (ag-reuse-window t)
  :bind
  ("M-s a" . ag-project)
  :config
  (use-package wgrep-ag))

;; Microsoft's language server protocol, LSP Server
(use-package server
  :ensure nil
  :hook (after-init . server-mode))

;; editing mode
;; WC TODO Mar 5, remove this as I don't think it does anything
;; Ignore split window horizontally
;;(setq split-width-threshold nil)
;;(setq split-width-threshold 160)

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
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq initial-scratch-message nil)
(tool-bar-mode 0)
(menu-bar-mode 0)
(defun display-startup-echo-area-message ()
  (message ""))

(setq frame-title-format nil)
(setq ring-bell-function 'ignore)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets) ; Show path if names are same
(setq adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*")
(setq adaptive-fill-first-line-regexp "^* *$")
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
;;(setq-default tab-width 4)
(defalias 'yes-or-no-p #'y-or-n-p)

;; Delete selection if insert someting
(use-package delsel
  :ensure nil
  :hook (after-init . delete-selection-mode))

;; Automatically reload files was modified by external program
(use-package autorevert
  :ensure nil
  :diminish
  :hook (after-init . global-auto-revert-mode))

;; Hungry deletion
(use-package hungry-delete
  :diminish
  :hook (after-init . global-hungry-delete-mode)
  :config (setq-default hungry-delete-chars-to-skip " \t\f\v"))

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

(if (display-graphic-p)
    (progn
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
                                        ;(use-package yasnippet
                                        ;  :ensure t
                                        ;  :diminish yas-minor-mode
                                        ;  :hook (after-init . yas-global-mode))

;; Magit
(use-package magit
  :custom
  (magit-auto-revert-mode nil)
  :bind
  ("M-g s" . magit-status))


;; Go Lang setup
(defun install-go ()
  (interactive)
  (if (system-is-linux)
      (call-process-shell-command "sudo apt-get install golang" nil (current-buffer) nil))
  (call-process-shell-command "go get -u github.com/mdempsky/gocode" nil (current-buffer) nil)
  (call-process-shell-command "go get -u github.com/derekparker/delve/cmd/dlv" nil (current-buffer) nil)
  (call-process-shell-command "go get -u github.com/kisielk/errcheck" nil (current-buffer) nil)
  (call-process-shell-command "go get -u golang.org/x/tools/cmd/godoc" nil (current-buffer) nil))

                                        ; ladicle golang
                                        ;(use-package go-mode
                                        ;  :mode "\\.go\\'"
                                        ;  :custom (gofmt-command "goimports"
                                        ;  :bind (:map go-mode-map
                                        ;    ("C-c C-n" . go-run)
                                        ;    ("C-c ."   . go-test-current-test)
                                        ;    ("C-c f"   . go-test-current-file)
                                        ;    ("C-c a"   . go-test-current-project))
                                        ;  :config
                                        ;    (add-hook 'before-save-hook #'gofmt-before-save)
                                        ;    (use-package gotest)
                                        ;    (use-package go-tag
                                        ;      :config (setq go-tag-args (list "-transform" "camelcase")))))
                                        ;
                                        ; end ladicle golang


(use-package go-guru
  :defer)
(use-package company 
  :ensure t
  :diminish company-mode
  :config
  (setq company-selection-wrap-around t)
  (setq company-minimum-prefex-length 1)
  (setq company-tooltip-align-annotations t)
  (add-hook 'after-init-hook #'global-company-mode)
  )

                                        ;(use-package company-box
                                        ;  :after company
                                        ;  :diminish
                                        ;  :hook (company-mode . company-box-mode))

(use-package go-mode
  :init
  (setq gofmt-command "goimports"     ; use goimports instead of gofmt
        go-fontify-function-calls nil ; fontifing names of called
                                        ; functions is too much for me
        company-idle-delay 1)         ; wait 1s before company popup
  :bind
  (:map go-mode-map
        ("M-."      . go-guru-definition)
        ("C-c h"    . go-guru-hl-identifier)
        ("C-c d"    . lsp-describe-thing-at-point)
        ("C-c g"    . godoc)
                                        ;      ("C-c P"   . my-godoc-package)
        ("C-i"      . company-indent-or-complete-common)
        ("C-M-i"    . company-indent-or-complete-common)
        )
  :config
  (require 'go-guru)
  (add-hook 'go-mode-hook #'lsp)
  ;;(add-hook 'go-mode-hook #'smartparens-mode)
  (add-hook 'go-mode-hook (lambda () (setq tab-width 4)))
  (add-hook 'before-save-hook #'gofmt-before-save))
                                        ;    (go-guru-hl-identifier-mode)
                                        ;    (local-set-key (kbd "M-.") 'godef-jump)
                                        ;    (local-set-key (kbd "M-*") 'pop-tag-mark)
                                        ;    (local-set-key (kbd "M-p") 'compile)
                                        ;    (local-set-key (kbd "M-P") 'recompile)
                                        ;    (local-set-key (kbd "M-]") 'next-error)
(set (make-local-variable 'compile-command) "go build -v && go test -v && go vet")

;; (use-package go-dlv)

;; (defun my-go-mode-hook()
;;  (use-package go-snippets :ensure t)
;;  (go-snippets-initialize)

;; ;;WC (autoload 'helm-go-package "helm-go-package") ;; Not necessary if using ELPA package
;;  (eval-after-load 'go-mode
;;  '(substitute-key-definition 'go-import-add 'helm-go-package go-mode-map))

;;  (add-hook 'before-save-hook 'gofmt-before-save)
;;  (setq gofmt-command "goimports")
;;  (if (not (string-match "go" compile-command))
;;    (set (make-local-variable 'compile-command) "go build -v && go test -v && go vet"))

;;  (local-set-key (kbd "C-c m") 'gofmt)
;;  ;; guru settings
;;  (go-guru-hl-identifier-mode)
;;  (local-set-key (kbd "M-.") 'godef-jump)
;;  (local-set-key (kbd "M-*") 'pop-tag-mark)
;;  (local-set-key (kbd "M-p") 'compile)
;;  (local-set-key (kbd "M-P") 'recompile)
;;  (local-set-key (kbd "M-]") 'next-error)
;;  (local-set-key (kbd "M-[") 'previous-error)
;;  ;; (auto-complete-mode 1)
;;  ;;(yas-minor-mode-on)

;;  (eval-after-load 'go-mode'
;;    '(progn
;;     (flycheck-declare-checker go-gofmt
;;                   "A Go syntax and style checker using the gofmt utility."
;;                   :command '("gofmt" source-inplace)
;;                   :error-patterns '(("^\\(?1:.*\\):\\(?2:[0-9]+\\):\\(?3:[0-9]+\\): \\(?4:.*\\)$" error))
;;                   :modes 'go-mode)
;;     (add-to-list 'flycheck-checkers 'go-gofmt)))
;;  (eval-after-load 'go-mode'
;;    '(require 'flymake-go))
;; )

;; (add-hook 'go-mode-hook (lambda ()
;;  (set (make-local-variable 'company-backends) '(company-go))
;;  (company-mode)))

;; (add-hook 'go-mode-hook 'my-go-mode-hook)
;; end Golang

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
  :config
  (setq-default indent-tabs-mode nil	;; rustfmt takes care of spaces, just don't use tabs
                company-idle-delay 1         		;; wait 1s before company popup
                rust-format-on-save t
                tab-width 4)
  ) 			;; requires `rustup component add rustfmt

(use-package racer :ensure t
  :config
  (progn
    (add-hook 'rust-mode-hook #'racer-mode) ;; Activate racer in rust buffers.
    (add-hook 'racer-mode-hook #'eldoc-mode) ;; Shows signature of current function in minibuffer.
    ;; Rust completions with Company and Racer.
    (add-hook 'racer-mode-hook #'company-mode)
    ))

;; Map TAB key to completions.
                                        ;(local-set-key (kbd "TAB") 'company-indent-or-complete-common)
                                        ;(setq company-tooltip-align-annotations t)

;; Path to rust source.
(when (equal system-type 'gnu/linux)
  (setq racer-rust-src-path (concat (getenv "RUSTUP_HOME") "/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"))
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
  :config
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'rust-mode-hook #'lsp)
  (setq lsp-prefer-flymake nil)
  )

(use-package company-lsp :commands company-lsp)

(use-package lsp-ui
                                        ;  :requires lsp-mode flycheck
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-delay 1.5    ;; delay time before func sig pops up
        lsp-ui-doc-max-width 40   ;; width of popup
        lsp-ui-doc-max-height 10  ;; height of popup
        lsp-ui-doc-position 'top  ;; top, bottom, at-point
        lsp-ui-doc-include-signature t
                                        ;      lsp-ui-sideline-enable t
                                        ;      lsp-ui-sideline-ignore-duplicate t
                                        ;      lsp-ui-sideline-show-symbol nil
                                        ;      lsp-ui-sideline-show-hover t
                                        ;      lsp-ui-sideline-show-diagnostics nil
                                        ;      lsp-ui-doc-use-webkit t
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'right
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 60
        lsp-ui-peek-peek-height 25)
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

;; Prettier for best JS formatting
;; Note - you have have prettier installed on OS npm install -g prettier
(use-package prettier-js
  :ensure t
  :config
  (add-hook 'web-mode-hook 'prettier-js-mode))
;; prettier rules should be project specific and kept in .prettierrc
;; (setq prettier-js-args '(
;;                          "--trailing-comma" "es5"
;;                          "--bracket-spacing" "true"
;;                          "--single-quote" "true"
;;                          "--no-semi" "false"
;;                          "--jsx-single-quote" "true"
;;                          "--jsx-bracket-same-line" "true"
;;                          "--print-width" "100")))

(use-package web-mode
  :ensure t
  :mode (("\\.html\\'" . web-mode)
         ("\\.[jt]sx?\\'" . web-mode))
  :config
  (setq web-mode-content-types-alist '(("jsx" . "\\.[jt]sx?\\'"))
        web-mode-markup-indent-offset 2
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

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
;; (defadvice web-mode-highlight-part (around tweak-jsx activate)
;;   (if (equal web-mode-content-type "jsx")
;;       (let ((web-mode-enable-part-face nil))
;;         ad-do-it)
;;     ad-do-it))

;; VueJS setup
(use-package vue-mode)
(use-package vue-html-mode)

(setq vue-mode-packages
      '(vue-mode))
(setq vue-mode-excluded-packages '())
(defun vue-mode/init-vue-mode ()
  "Initialize my package"
  (use-package vue-mode))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-highlight-search t t)
 '(ag-reuse-buffers t t)
 '(ag-reuse-window t t)
 '(custom-safe-themes
   '("a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "1a212b23eb9a9bedde5ca8d8568b1e6351f6d6f989dd9e9de7fba8621e8ef82d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "bf798e9e8ff00d4bf2512597f36e5a135ce48e477ce88a0764cfb5d8104e8163" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "2540689fd0bc5d74c4682764ff6c94057ba8061a98be5dd21116bf7bf301acfb" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "d7383f47263f7969baf3856ab8b3df649eb77eafdff0c5731bee2ad18e0faed2" "a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default))
 '(ivy-count-format "%d/%d " t)
 '(ivy-use-virtual-buffers t t)
 '(magit-auto-revert-mode nil)
 '(package-selected-packages
   '(alect-themes gruber-darker-theme ample-theme color-theme-sanityinc-tomorrow afternoon-theme wgrep-ag solarized-theme cargo yasnippet yaml-mode which-key use-package subatomic256-theme smartparens rainbow-delimiters racer quelpa protobuf-mode powerline pbcopy markdown-toc magit lsp-ui ivy hungry-delete go-guru flycheck-rust diminish company-lsp all-the-icons)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
