layout.rb  用 book-zh 模板替换 book 模板

getchinese 从中英文混合版中提取中文（bash 脚本）

zh.rb 也是从中英文混合版中提取中文（ruby 实现）

nodivcode 保留这样的块元素

```html
<div class="single">
  blabla...
</div>
```

makepdf 目录是生成中文 pdf 的工具，首先需要安装 `kramdown`,

```ruby
gem install kramdown
```
然后，就可以运行以下命令生成中文 pdf 了

```ruby
ruby makepdf.rb
```
