(set-face-font 'default (font-spec :family "Source Code Pro" :size 22) )

(unless  (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package doom-modeline
  :ensure t
  :config (doom-modeline-mode 1))

(use-package shell-pop
  :ensure t
  :bind ("C-`" . shell-pop)
  :custom
  (shell-pop-window-position "buttom")
  (shell-pop-full-span t))

(defvar dual-ro-map
  (let ((map (make-keymap))
        (keybindings '(
                       ("n" . next-line)
                       ("p" . previous-line)
                       ("a" . move-beginning-of-line)
                       ("e" . move-end-of-line)
                       ("f" . forward-char)
                       ("b" . backward-char)
                       )))
    (suppress-keymap map)
    (dolist (it keybindings map)
      (define-key map (car it) (cdr it)))))

(define-advice read-only-mode (:after (&rest _) ro-adv)
  (use-local-map (if buffer-read-only dual-ro-map nil)))

(global-set-key (kbd "C-x x") 'recentf-open-files)

(global-hl-line-mode t)

(provide 'init-local)
