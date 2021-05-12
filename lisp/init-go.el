(use-package go-mode
  :ensure t
  :mode "\\.go^\\'"
  ;; :hook
  ;; (go-mode . 'lsp-deferred)
  ;; (before-save . 'gofmt-before-save)
  :custom
  (tab-width 4)
  (company-idle-delay 0.3)
  (gofmt-command "goimports")
  :bind ("C-c C-c" . (lambda ()
                       (interactive)
                       (setq compile-command  (format "go run %s" buffer-file-name) )
                       (recompile))))

(add-hook 'go-mode-hook 'lsp-deferred)
(add-hook 'before-save-hook 'gofmt-before-save)

(provide 'init-go)
