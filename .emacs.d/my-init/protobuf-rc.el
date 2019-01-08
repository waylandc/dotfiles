(use-package protobuf-mode)

(defconst my-protobuf-style
	'((c-basic-offset . 4)
		(indent-tabs-mode . t)))

(add-hook 'protobuf-mode-hook
	(lambda () (c-add-style "my-style" my-protobuf-style t)))
