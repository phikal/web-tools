;; to be executed with `emacs -nw -Q --script exconf.el'

(add-to-list 'load-path (expand-file-name (car (file-expand-wildcards "~/.emacs.d/elpa/htmlize-*"))))

(require 'org)
(require 'htmlize)

(setq make-backup-files nil
	  org-edit-src-content-indentation 0
	  org-html-doctype "xhtml5"
	  org-html-head-include-scripts t
	  org-html-html5-fancy t
	  org-html-head (concat
					 "<link rel=\"stylesheet\" href=\"/normalize.css\" />"
					 "<link rel=\"stylesheet\" href=\"/style.css\" />"))

(find-file (expand-file-name "conf.org" user-emacs-directory))

;;; replace all tabs with 4 spaces
(goto-char (point-min))
(while (search-forward "\t" nil t)
    (replace-match "    "))

(org-html-export-as-html)
(switch-to-buffer "*Org HTML Export*")
(goto-char (point-min))
(search-forward "<body>")
(insert (with-temp-buffer
		  (insert-file-literally "~/code/web/www/head.html")
		  (let ((beg (goto-char (point-min))))
			(search-forward "<body>")
			(delete-region beg (point)))
		  (goto-char (1- (point-max)))
		  (beginning-of-line)
		  (kill-line)
		  (buffer-string)))
(write-file (expand-file-name "~/code/web/www/www/emacs.d.html"))
