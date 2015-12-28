## UIImageView-AutoAdapter
--------
### What's the UIImageView-AutoAdapter
在实际的开发项目中，经常遇到`UIImageView`与`UIImage`的大小无法适配的情况，使得显示的图片以拉伸、压缩、旁边留白等形式显示，效果很不理想。[UIImageView-AutoAdapter](https://github.com/Jiar/UIImageView-AutoAdapter)正是为了解决这个问题出现的，实现自动适配`UIImage`，使得图片以正常的宽高比显示，无拉伸缩放等影响。
![UIImageView-AutoAdapter show](/images/UIImageView+AutoAdapter.jpg?raw=true)  
上图由两部分组成，左边为xib中图片的显示形式，右边为实际在真机上图片的显示形式。在左边的显示效果中我们可以看到，图片以拉伸或是压缩的形式显示，而右边的显示效果中，图片以理想的效果显示。

> 最后一张图片由于我在代码中设置了关闭了使用`UIImageView-AutoAdapter`，因此两边最后一张图片的显示效果一样。

由此可见，使用`UIImageView-AutoAdapter`即可轻松解决图片适应问题。

### How To Get Started

- 下载[UIImageView-AutoAdapter](https://github.com/Jiar/UIImageView-AutoAdapter)并尝试在真机或者模拟器上运行。

### Installation with CocoaPods
#### Podfile
	platform :ios, '7.0'
	pod "UIImageView-AutoAdapter"
### Usage
`UIImageView-AutoAdapter`使用了`runtime`黑魔法，你不需要进行任何额外的调用就可以直接使用。当然，如果你想让某个`UIImageView`不使用`UIImageView-AutoAdapter`，你可以用如下方式为这个`UIImageView`关闭使用`UIImageView-AutoAdapter`。
        
        #import "KeyboardToolBar.h"
        
        // imageView是UIImageView的实例对象
        [imageView setCloseAdapter:YES];

### License
[UIImageView-AutoAdapter](https://github.com/Jiar/UIImageView-AutoAdapter)使用了MIT开源协议。