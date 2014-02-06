wtails
======

Wtails is a web server acts like 'tails -f', based on webtail( https://github.com/r7kamura/webtail ).

You can watch multiple files with slider UI.

Wtails can serve files without launching browser(--serve), this option is usable for watching remote files.

install
=======

  % gem install wtails

usage
=====

  % wtails foo.log bar.log baz.log - --serve

  then web server started, and you can now browse them at 'http://localhost:9999'.

screenshot
==========

single view
-----------
  ![single view](https://raw.github.com/jonigata/wtails/master/doc/img/single_view.png)

dual (upper/lower) view
-----------------------
  ![dual view](https://raw.github.com/jonigata/wtails/master/doc/img/dual_view.png)

.wtailsrc
=========

  Semantics of .wtailsrc is different from webtail. You should modify 'line' local variable.

  example:

```
$ cat ~/.webtailrc
var text = line.text();

if (text == '\n') {
  line.css({
    margin: '3em 0',
    height: 1,
    background: 'lime'
  });
}

if (text.match(/require|opt/)) {
  line.css({
    color: '#E1017B'
  });
}
```
