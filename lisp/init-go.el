(use-package go-mode
  :ensure t
  :mode "\\.go^\\'"
  ;; :hook
  ;; (go-mode . 'lsp-deferred)
  ;; (before-save . 'gofmt-before-save)
  :custom
  (compile-command "go build && ./demo")
  (tab-width 4)
  (company-idle-delay 0.3)
  (gofmt-command "goimports")
  :bind ("C-c C-c" . 'recompile))

(add-hook 'go-mode-hook 'lsp-deferred)
(add-hook 'before-save-hook 'gofmt-before-save)

(provide 'init-go)
