;; Flycheck-Begin. On the fly syntax checking for multiple programming languages.
;; Enable Flycheck in buffers with supported languages.
(use-package flycheck :ensure t)
(use-package flycheck-rust :ensure t)
(use-package rust-mode :ensure t
  :config
  (setq rust-format-on-save t))

(use-package racer :ensure t)
(use-package company :ensure t
  :config
  (setq company-idle-delay 0.2)
  (add-hook 'rust-mode-hook
    (lambda ()
      (setq-local company-tooltip-align-annotations t))))

(add-hook 'after-init-hook #'global-flycheck-mode)

;; Flycheck Rust support.
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
;; Flycheck-End.

;; Rust programming language-Begin.
;; See Flycheck for syntax checking.
;; Racer package configuration. For rust programming language support.
;; Path to rust source.
(setq racer-rust-src-path (concat (getenv "HOME") "/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"))
;; Racer bin path.
(setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))
(add-hook 'rust-mode-hook #'racer-mode) ;; Activate racer in rust buffers.
(add-hook 'racer-mode-hook #'eldoc-mode) ;; Shows signature of current function in minibuffer.

;; Rust completions with Company and Racer.
(add-hook 'racer-mode-hook #'company-mode)

;; Map TAB key to completions.
(local-set-key (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

;; Rust Formatter. Run rustfmt before saving rust buffers
;;(add-hook 'rust-mode-hook #'rustfmt-enable-on-save)
;; Rust-End.

