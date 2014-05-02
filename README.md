# helm-ack.el

## Introduction
`helm-ack.el` is App::ack helm interface.

## Screenshot

![helm-ack](https://github.com/syohex/emacs-helm-ack/raw/master/image/helm-ack.png)


## Requirements

* Emacs 23 or higher
* helm 1.0 or higher
* [App::Ack](https://metacpan.org/module/ack) or `ack-grep` debian package.


## Basic Usage

#### `helm-ack`

Input search word with ack. If you specified prefix argument(`C-u`), you can
change searched directory.

#### `helm-ack-pop-stack`

Move to previous point on the stack.


## Customize

#### `helm-ack-use-ack-grep`(Default is `nil`)

If you install ack as debian package, please set `t` to this variable.

#### `helm-ack-base-command`

Base ack command, default is "ack --nocolor --nogroup"

#### `helm-ack-auto-set-filetype`
Auto insert `--type` option, default is true.

#### `helm-ack-thing-at-point`

Insert thing at point as default search pattern, you can set the value
same as `thing-at-point`. If you set nil or use negative prefix-key
(`C--` or `M--`), `helm-ack.el` does not insert anything.
Default value is `'word`.


## Sample Configuration

```lisp
(require 'helm-config)
(require 'helm-ack)

(custom-set-variables
 ;; Does not insert '--type' option
 '(helm-ack-auto-set-filetype nil)
 ;; Insert "thing-at-point 'symbol" as search pattern
 '(helm-ack-thing-at-point 'symbol))
```
