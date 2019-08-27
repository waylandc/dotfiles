;; Flycheck-Begin. On the fly syntax checking for multiple programming languages.
;; Enable Flycheck in buffers with supported languages.
(use-package flycheck :ensure t)
(use-package flycheck-rust :ensure t)
(use-package rust-mode :ensure t
  :config
  (setq rust-format-on-save t))

(use-package racer :ensure t
  :config
  (progn
	(add-hook 'rust-mode-hook #'racer-mode) ;; Activate racer in rust buffers.
	(add-hook 'racer-mode-hook #'eldoc-mode) ;; Shows signature of current function in minibuffer.
	;; Rust completions with Company and Racer.
	(add-hook 'racer-mode-hook #'company-mode)))

(use-package company :ensure t
  :config
  (setq company-idle-delay 0.2)
  (add-hook 'racer-mode-hook
    (lambda ()
      (setq-local company-tooltip-align-annotations t))))

;; Enable Cargo minor mode
(use-package cargo :ensure t
  :config
  (add-hook 'rust-mode-hook 'cargo-minor-mode))

(add-hook 'after-init-hook #'global-flycheck-mode)

;; Flycheck Rust support.
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
;; Flycheck-End.

;; Path to rust source.
(setq racer-rust-src-path (concat (getenv "HOME") "/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"))
;; Racer bin path.
(setq racer-cmd (concat (getenv "HOME") "/.cargo/bin/racer"))

;; Map TAB key to completions.
(local-set-key (kbd "TAB") 'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

;; Rust-End.
