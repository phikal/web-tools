;; to be executed with `emacs -nw -Q --script exconf.el'

(require 'org)

(add-to-list 'load-path (expand-file-name "elpa/htmlize-1.53" user-emacs-directory))
(require 'htmlize)

(setq-default make-backup-files nil
			  org-html-doctype "xhtml5"
			  org-html-link-home "/"
			  org-html-head-include-scripts nil
			  org-html-html5-fancy t
			  org-html-head "<link rel=\"stylesheet\" href=\"/normalize.css\" />
<style>
body { margin: 0.5em; }
div#content {
	max-width: 60em;
	text-align: justify;
	margin: 2% auto;
    font-family: Tahoma, Geneva, sans-serif;
}
</style>")

(find-file (expand-file-name "conf.org" user-emacs-directory))
(org-html-export-as-html)
(switch-to-buffer "*Org HTML Export*")
(write-file (expand-file-name "~/code/web/www/www/emacs.d.html"))
